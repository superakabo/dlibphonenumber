/**
 * @license
 * Copyright (C) 2023 Samuel Akabo.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @fileoverview  Utility for parsing PhoneNumbersMetadata.xml and 
 * PhoneNumbersMetadataForTesting.xml into JSON based on phonemetadata.proto
 */


'use strict';

import * as fs from 'fs';
import * as path from 'path';
import { promisify } from 'util';
import jsdom from 'jsdom';
const { JSDOM } = jsdom;

start();

function isTestMode(): boolean {
    const args = process.argv.slice(2);
    return (args[0] == 'true');
}

function getMetadataFileName(): string {
    return (isTestMode())
        ? 'PhoneNumberMetadataForTesting.xml'
        : 'PhoneNumberMetadata.xml';
}

async function readXml(): Promise<string> {
    const filePath = `../resources/${getMetadataFileName()}`;
    const readFile = promisify(fs.readFile);
    return await readFile(filePath, 'utf-8');
}

async function getDom() {
    const xml = await readXml();
    return new JSDOM(xml);
}

async function start() {
    const dom = await getDom();
    const nodes = dom.window.document.querySelectorAll('territory');
    const elements = Array.from(nodes);
    await generateJsonForRegions(elements);
    await generateCountryCodeToRegionCodeMap(elements);
}

async function generateJsonForRegions(elements: Element[]) {
    const testMode = isTestMode();
    const subDir = (testMode) ? 'test_data' : 'data';
    const comment = `/// This is auto generated from ${getMetadataFileName()}. Do not modify.`
    const metadataImports: string[] = [];
    let metadataMap: string = '';

    for (const e of elements) {
        const id = getId(e);
        const regionName = isNaN(parseInt(id)) ? id : `${getCountryCode(e)}`;
        const jsonString = JSON.stringify(parseTerritory(e)).replaceAll('$', '\\$');
        const functionFileName = `phone_number_metadata_${regionName.toLowerCase()}.dart`;
        const functionName = `phoneNumberMetadata${regionName}`;
        const output = `${comment}\n\nMap<String, List<Object>> get ${functionName} { return ${jsonString}; }`;

        const filePath = `../lib/generated/${subDir}/${functionFileName}`;
        await writeJsonToFile(filePath, output);

        metadataImports.push(`import "${subDir}/${functionFileName}";`);
        metadataMap += `"${regionName}": ${functionName},\n`;
    }

    const functionName = (testMode) ? 'phoneNumberMetdataTest' : 'phoneNumberMetdata';
    const output = `${comment}\n\nMap<String, Map<String, List<Object>>> get ${functionName} { return { ${metadataMap} }; }`;
    const fileName = (testMode) ? 'phone_number_metdata_test' : 'phone_number_metdata';
    const filePath = `../lib/generated/${fileName}.dart`;
    await writeJsonToFile(filePath, `${metadataImports.join('\n')}\n\n${output}`);
}

async function generateCountryCodeToRegionCodeMap(elements: Element[]) {
    const results: { [key: number]: string[] } = {};

    for (const e of elements) {
        const countryId = getId(e);
        const countryCode = getCountryCode(e);
        const isMainCountryForCode: boolean = getMainCountryForCode(e);
        const countryIds = results[countryCode] ?? [];

        if (isMainCountryForCode) {
            countryIds.unshift(countryId);
            results[countryCode] = countryIds;
        } else {
            countryIds.push(countryId);
            results[countryCode] = countryIds;
        }
    }

    let jsonText: string = '';
    for (const key in results) {
        const value = results[key];
        jsonText += `${key}: ${JSON.stringify(value)},\n`;
    }

    const functionName = (isTestMode())
        ? 'countryCodeToRegionCodeMapTest'
        : 'countryCodeToRegionCodeMap';

    const CountryCodeToRegionCodeMap = `
    /// Based on the original Java code: .../phonenumbers/CountryCodeToRegionCodeMap.java
    ///
    /// Copyright (C) 2009 The Libphonenumber Authors
    ///
    /// Licensed under the Apache License, Version 2.0 (the "License");
    /// you may not use this file except in compliance with the License.
    /// You may obtain a copy of the License at
    ///
    /// http://www.apache.org/licenses/LICENSE-2.0
    ///
    /// Unless required by applicable law or agreed to in writing, software
    /// distributed under the License is distributed on an "AS IS" BASIS,
    /// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    /// See the License for the specific language governing permissions and
    /// limitations under the License.
    ///
    
    /// This file is automatically generated by [BuildMetadataProtoFromXml].
    /// Please don't modify it directly.
    ///
    
    // A mapping from a country code to the region codes which denote the
    // country/region represented by that country code. In the case of multiple
    // countries sharing a calling code, such as the NANPA countries, the one
    // indicated with 'isMainCountryForCode' in the metadata should be first.

    Map<int, List<String>> get ${functionName} {
        return { ${jsonText} };
    }`;

    const fileName = (isTestMode())
        ? 'country_code_to_region_code_map_test.dart'
        : 'country_code_to_region_code_map.dart';

    const filePath = `../lib/generated/${fileName}`;
    await writeJsonToFile(filePath, CountryCodeToRegionCodeMap);
}

async function writeJsonToFile(filePath: string, data: string): Promise<void> {
    try {
        const writer = promisify(fs.writeFile);
        const mkdir = promisify(fs.mkdir);
        const directoryPath = path.dirname(filePath);
        await mkdir(directoryPath, { recursive: true });
        return await writer(filePath, data, 'utf-8');
    } catch (error) {
        console.error('Error writing to file:', error);
    }
}

function parseTerritory(e: Element): { [key: string]: any[] } {
    return {
        metadata: [{
            id: getId(e),
            country_code: getCountryCode(e),
            international_prefix: getInternationalPrefix(e),
            preferred_international_prefix: getPreferredInternationalPrefix(e),
            national_prefix: getNationalPrefix(e),
            preferred_extn_prefix: getPreferredExtnPrefix(e),
            national_prefix_for_parsing: getNationalPrefixForParsing(e),
            national_prefix_transform_rule: getNationalPrefixTransformRule(e),
            same_mobile_and_fixed_line_pattern: getSameMobileAndFixedLinePattern(e),
            main_country_for_code: getMainCountryForCode(e),
            leading_digits: getLeadingDigits(e),
            mobile_number_portable_region: getMobileNumberPortableRegion(e),
            general_desc: getGeneralDesc(e),
            fixed_line: _getGroup(e, 'fixedLine'),
            mobile: _getGroup(e, 'mobile'),
            toll_free: _getGroup(e, 'tollFree'),
            premium_rate: _getGroup(e, 'premiumRate'),
            shared_cost: _getGroup(e, 'sharedCost'),
            personal_number: _getGroup(e, 'personalNumber'),
            voip: _getGroup(e, 'voip'),
            pager: _getGroup(e, 'pager'),
            uan: _getGroup(e, 'uan'),
            emergency: _getGroup(e, 'emergency'),
            voicemail: _getGroup(e, 'voicemail'),
            short_code: _getGroup(e, 'shortCode'),
            standard_rate: _getGroup(e, 'standardRate'),
            carrier_specific: _getGroup(e, 'carrierSpecific'),
            sms_services: _getGroup(e, 'smsServices'),
            no_international_dialling: _getGroup(e, 'noInternationalDialling'),
            number_format: getNumberFormat(e),
            intl_number_format: getIntlNumberFormat(e),
        }],
    }
}

function getId(e: Element): string {
    return e.getAttribute('id') ?? '';
}

function getCountryCode(e: Element): number {
    return parseInt(e.getAttribute('countryCode') ?? '0');
}

function getInternationalPrefix(e: Element): string | null {
    return e.getAttribute('internationalPrefix') ?? null;
}

function getPreferredInternationalPrefix(e: Element): string | null {
    return e.getAttribute('preferredInternationalPrefix') ?? null;
}

function getNationalPrefix(e: Element): string | null {
    return e.getAttribute('nationalPrefix') ?? null;
}

function getPreferredExtnPrefix(e: Element): string | null {
    return e.getAttribute('preferredExtnPrefix') ?? null;
}

function getNationalPrefixForParsing(e: Element): string | null {
    const nationalPrefixForParsing = e.getAttribute('nationalPrefixForParsing');
    const nationalPrefix = getNationalPrefix(e);
    const prefix = nationalPrefixForParsing ?? nationalPrefix;
    return prefix
        ?.replaceAll('\n', '')
        .replaceAll(' ', '') ?? null;
}

function getNationalPrefixTransformRule(e: Element): string | null {
    return e.getAttribute('nationalPrefixTransformRule') ?? null;
}

function getSameMobileAndFixedLinePattern(e: Element): boolean {
    const value = e.getAttribute('sameMobileAndFixedLinePattern')
        ?.replaceAll('\n', '')
        .replaceAll(' ', '');
    return (value === 'true');
}

function getMainCountryForCode(e: Element): boolean {
    const value = e.getAttribute('mainCountryForCode');
    return (value === 'true');
}

function getLeadingDigits(e: Element): string | null {
    return e.getAttribute('leadingDigits') ?? null;
}

function getMobileNumberPortableRegion(e: Element): boolean {
    const value = e.getAttribute('mobileNumberPortableRegion');
    return (value === 'true');
}

function getGeneralDesc(e: Element): { [key: string]: any } {
    const possibleLengthSet = new Set<number>();
    const possibleLengthLocalSet = new Set<number>();
    let possibleLength: number[] = [];
    let possibleLengthLocal: number[] = [];

    const fixedLine = _getGroup(e, 'fixedLine');
    possibleLength = fixedLine?.possible_length ?? [];
    possibleLengthLocal = fixedLine?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const mobile = _getGroup(e, 'mobile');
    possibleLength = mobile?.possible_length ?? [];
    possibleLengthLocal = mobile?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const tollFree = _getGroup(e, 'tollFree');
    possibleLength = tollFree?.possible_length ?? [];
    possibleLengthLocal = tollFree?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const premiumRate = _getGroup(e, 'premiumRate');
    possibleLength = premiumRate?.possible_length ?? [];
    possibleLengthLocal = premiumRate?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const sharedCost = _getGroup(e, 'sharedCost');
    possibleLength = sharedCost?.possible_length ?? [];
    possibleLengthLocal = sharedCost?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const personalNumber = _getGroup(e, 'personalNumber');
    possibleLength = personalNumber?.possible_length ?? [];
    possibleLengthLocal = personalNumber?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const voip = _getGroup(e, 'voip');
    possibleLength = voip?.possible_length ?? [];
    possibleLengthLocal = voip?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const pager = _getGroup(e, 'pager');
    possibleLength = pager?.possible_length ?? [];
    possibleLengthLocal = pager?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const uan = _getGroup(e, 'uan');
    possibleLength = uan?.possible_length ?? [];
    possibleLengthLocal = uan?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const emergency = _getGroup(e, 'emergency');
    possibleLength = emergency?.possible_length ?? [];
    possibleLengthLocal = emergency?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const voicemail = _getGroup(e, 'voicemail');
    possibleLength = voicemail?.possible_length ?? [];
    possibleLengthLocal = voicemail?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const shortCode = _getGroup(e, 'shortCode');
    possibleLength = shortCode?.possible_length ?? [];
    possibleLengthLocal = shortCode?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const standardRate = _getGroup(e, 'standardRate');
    possibleLength = standardRate?.possible_length ?? [];
    possibleLengthLocal = standardRate?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const carrierSpecific = _getGroup(e, 'carrierSpecific');
    possibleLength = carrierSpecific?.possible_length ?? [];
    possibleLengthLocal = carrierSpecific?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const smsServices = _getGroup(e, 'smsServices');
    possibleLength = smsServices?.possible_length ?? [];
    possibleLengthLocal = smsServices?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const noInternationalDialling = _getGroup(e, 'noInternationalDialling');
    possibleLength = noInternationalDialling?.possible_length ?? [];
    possibleLengthLocal = noInternationalDialling?.possible_length_local_only ?? [];
    possibleLength.forEach((f) => { if (f != -1) possibleLengthSet.add(f) });
    possibleLengthLocal.forEach((f) => { if (f != -1) possibleLengthLocalSet.add(f) });

    const node = e.querySelector('generalDesc');
    return {
        national_number_pattern: _getNationalNumberPattern(node),
        possible_length: Array.from(possibleLengthSet),
        possible_length_local_only: Array.from(possibleLengthLocalSet),
        example_number: _getExampleNumber(node),
    };
}

function getNumberFormat(e: Element): { [key: string]: any }[] {
    const nodes = e.querySelectorAll('numberFormat');
    return Array.from(nodes).map((f) => {
        return {
            pattern: _getPattern(f),
            format: _getFormat(f),
            leading_digits_pattern: _getLeadingDigitsPattern(f),
            national_prefix_optional_when_formatting: _getNationalPrefixOptionalWhenFormatting(f),
            national_prefix_formatting_rule: _getPrefixFormattingRule(e, f, 'nationalPrefixFormattingRule'),
            domestic_carrier_code_formatting_rule: _getPrefixFormattingRule(e, f, 'carrierCodeFormattingRule'),
        }
    });
}

function getIntlNumberFormat(e: Element): any[] {
    const nodes = e.querySelectorAll('numberFormat');
    const elements = Array.from(nodes).filter((f) => _hasIntlFormat(f));

    return elements.map((f) => {
        const intFormat = _getIntlFormat(f);
        const format = (intFormat) ? intFormat : _getFormat(f);
        return {
            pattern: _getPattern(f),
            format: format,
            leading_digits_pattern: _getLeadingDigitsPattern(f),
            national_prefix_formatting_rule: _getPrefixFormattingRule(e, f, 'nationalPrefixFormattingRule'),
            domestic_carrier_code_formatting_rule: _getPrefixFormattingRule(e, f, 'carrierCodeFormattingRule'),
            national_prefix_optional_when_formatting: _getNationalPrefixOptionalWhenFormatting(f),
        }
    });
}

function _getGroup(e: Element, selector: string): { [key: string]: any } | null {
    const node = e.querySelector(selector);
    const nationalLength = _getPossibleLengths(node, 'national');
    const localOnlyLength = _getPossibleLengths(node, 'localOnly');
    return {
        national_number_pattern: _getNationalNumberPattern(node),
        possible_length: (nationalLength) ? nationalLength : [-1],
        possible_length_local_only: (localOnlyLength) ? localOnlyLength : [-1],
        example_number: _getExampleNumber(node),
    };
}

function _getNationalNumberPattern(e: Element | null): string | null {
    return e?.querySelector('nationalNumberPattern')
        ?.textContent
        ?.replaceAll('\n', '')
        ?.replaceAll(' ', '') ?? null;
}

function _getPossibleLengths(e: Element | null, attributeName: string): number[] | undefined {
    const nodes = e?.querySelectorAll(`possibleLengths[${attributeName}]`) ?? [];
    let lengths: number[] | undefined;

    function expand(ranges: string[] | undefined | null) {
        if (ranges) {
            if (!lengths) lengths = [];
            for (const s of ranges) {
                if (s.includes('-')) {
                    const subRanges: number[] = JSON.parse(s.replace('-', ','))
                    const start = subRanges[0];
                    const end = subRanges[1];
                    lengths = lengths.concat(Array.from({ length: end - start + 1 }, (_, i) => start + i));
                } else {
                    lengths.push(parseInt(s));
                }
            }
        }
    }

    Array.from(nodes)
        .map((f) => f.getAttribute(`${attributeName}`))
        .forEach((s) => expand(s?.split(',')));

    return lengths;
}

function _getExampleNumber(e: Element | null): string | null {
    return e?.querySelector('exampleNumber')?.textContent ?? null;
}

function _getPattern(e: Element): string | null {
    return e?.getAttribute('pattern')
        ?.replaceAll('\n', '')
        .replaceAll(' ', '') ?? null;
}

function _getFormat(e: Element): string | null {
    return e?.querySelector('format')?.textContent ?? null;
}

function _getIntlFormat(e: Element): string | null {
    return e?.querySelector('intlFormat')?.textContent ?? null;
}

function _hasIntlFormat(e: Element): boolean {
    const intFormat = _getIntlFormat(e);
    return (intFormat != 'NA');
}

function _getLeadingDigitsPattern(e: Element): (string | null)[] {
    const nodes = e.querySelectorAll('leadingDigits');
    return Array.from(nodes).map((e) => {
        return e.textContent?.replaceAll('\n', '').replaceAll(' ', '') ?? null;
    });
}

function _getPrefixFormattingRule(e: Element, f: Element, attribute: string): string | null {
    const rootRule = e.getAttribute(attribute);
    const childRule = f.getAttribute(attribute);
    const rule = childRule ?? rootRule;

    const rootFormat = _getFormat(e);
    const childFormat = _getFormat(f);
    const format = childFormat ?? rootFormat;

    const prefix = getNationalPrefix(e);
    const match = format?.match(RegExp("\\$(\\d+)"));
    if (match) {
        const firstGroup = match[1];
        return rule
            ?.replace('$NP', prefix ?? '')
            ?.replace('FG', firstGroup) ?? null;
    }

    return null;
}

function _getNationalPrefixOptionalWhenFormatting(e: Element): boolean {
    const value = e.getAttribute('nationalPrefixOptionalWhenFormatting');
    return (value === 'true');
}

