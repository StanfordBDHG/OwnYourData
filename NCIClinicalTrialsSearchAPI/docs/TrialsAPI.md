# TrialsAPI

All URIs are relative to *https://clinicaltrialsapi.cancer.gov/api/v2*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getTrialById**](TrialsAPI.md#gettrialbyid) | **GET** /trials/{id} | Get One Trial
[**searchTrialsByGet**](TrialsAPI.md#searchtrialsbyget) | **GET** /trials | Search Trials by GET
[**searchTrialsByPost**](TrialsAPI.md#searchtrialsbypost) | **POST** /trials | Search Trials by POST


# **getTrialById**
```swift
    open class func getTrialById(id: String, completion: @escaping (_ data: TrialDetail?, _ error: Error?) -> Void)
```

Get One Trial

<h3>GET trials&lt;id&gt;</h3><br><br><p>Retrieves the clinical trial with supplied <code>nci_id</code> or <code>nct_id</code>. <a href=\"/api/v2/docs/trial.json\" target='_blank' rel='noreferrer noopener'>All fields</a> (including nested ones) are returned.</p><hr>

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = "id_example" // String | NCI ID or NCT ID of Trial.

// Get One Trial
TrialsAPI.getTrialById(id: id) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** | NCI ID or NCT ID of Trial. | 

### Return type

[**TrialDetail**](TrialDetail.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchTrialsByGet**
```swift
    open class func searchTrialsByGet(size: Int? = nil, from: Int? = nil, sort: String? = nil, order: String? = nil, missing: String? = nil, exists: String? = nil, include: String? = nil, exclude: String? = nil, export: String? = nil, email: String? = nil, filename: String? = nil, fulltext: String? = nil, fieldParamFulltext: String? = nil, trialids: String? = nil, trialIds: String? = nil, keyword: String? = nil, keywordField: String? = nil, aggField: String? = nil, aggName: String? = nil, aggMinCount: Int? = nil, sitesOrgNameFulltext: String? = nil, trialStatus: String? = nil, nciFunded: String? = nil, nciId: String? = nil, nctId: String? = nil, protocolId: String? = nil, ccrId: String? = nil, ctepId: String? = nil, dcpId: String? = nil, currentTrialStatus: String? = nil, phase: String? = nil, studyProtocolType: String? = nil, nciPrograms: String? = nil, briefTitle: String? = nil, briefSummary: String? = nil, officialTitle: String? = nil, primaryPurpose: String? = nil, acceptsHealthyVolunteersIndicator: String? = nil, eligibilityStructuredAcceptsHealthyVolunteers: Bool? = nil, acronym: String? = nil, amendmentDate: String? = nil, anatomicSites: String? = nil, armsDescription: String? = nil, armsName: String? = nil, armsType: String? = nil, armsInterventionsNciThesaurusConceptId: String? = nil, armsInterventionsDescription: String? = nil, armsInterventionsName: String? = nil, armsInterventionsType: String? = nil, armsInterventionsSynonyms: String? = nil, associatedStudiesStudyId: String? = nil, associatedStudiesStudyIdType: String? = nil, eligibilityStructuredGender: String? = nil, eligibilityStructuredMinAgeInYearsLte: Int? = nil, eligibilityStructuredMinAgeInYearsGte: Int? = nil, eligibilityStructuredMaxAgeInYearsLte: Int? = nil, eligibilityStructuredMaxAgeInYearsGte: Int? = nil, eligibilityStructuredMinAgeUnit: String? = nil, eligibilityStructuredMinAgeNumberLte: Int? = nil, eligibilityStructuredMinAgeNumberGte: Int? = nil, eligibilityStructuredMaxAgeUnit: String? = nil, eligibilityStructuredMaxAgeNumberLte: Int? = nil, eligibilityStructuredMaxAgeNumberGte: Int? = nil, currentTrialStatusDateLte: String? = nil, currentTrialStatusDateGte: String? = nil, recordVerificationDateLte: String? = nil, recordVerificationDateGte: String? = nil, sitesOrgCoordinatesLat: Double? = nil, sitesOrgCoordinatesLon: Double? = nil, sitesOrgCoordinatesDist: String? = nil, sitesContactEmail: String? = nil, sitesContactName: String? = nil, sitesContactNameAuto: String? = nil, sitesContactNameRaw: String? = nil, sitesContactPhone: String? = nil, sitesOrgAddressLine1: String? = nil, sitesOrgAddressLine2: String? = nil, sitesOrgCity: String? = nil, sitesOrgPostalCode: String? = nil, sitesOrgStateOrProvince: String? = nil, sitesOrgCountry: String? = nil, sitesOrgCountryRaw: String? = nil, sitesOrgEmail: String? = nil, sitesOrgFamily: String? = nil, sitesOrgFax: String? = nil, sitesOrgName: String? = nil, sitesOrgNameAuto: String? = nil, sitesOrgNameRaw: String? = nil, sitesOrgPhone: String? = nil, sitesRecruitmentStatus: String? = nil, sitesRecruitmentStatusDate: String? = nil, sitesRecruitmentStatusDateLte: String? = nil, sitesRecruitmentStatusDateGte: String? = nil, leadOrgCancerCenter: String? = nil, completion: @escaping (_ data: TrialResponse?, _ error: Error?) -> Void)
```

Search Trials by GET

<h3>GET trials?&lt;filter_params&gt;</h3><br><p>This endpoint filters all clinical trials based upon supplied filter params. Filter params may be any of the <a href=\"/api/v2/docs/trial.json\" target='_blank' rel='noreferrer noopener'>fields in the schema</a> and others for more filtering capabilities as described below.</p><p><code>&lt;field_param&gt;</code>: filter results by examining a field by it's default search setting. For example a boolean field will expect true/false, number fields expect numbers and text fields expect text fields. Note that most SHORT text fields are by default set to be searched by exact match except they are case insensive, while LONG text fields like descriptions are by default set to be searched by fulltext as described below. Should one need to search differently, for example by typeahead or exact match including case, the options for doing such are listed below.</p><p><code>&lt;field_param&gt;._fulltext</code>: (note <b>.</b> before <b>&#95;</b>) filter results by examining a field for occurrence of a 'word' equal to the given value or a variation of it.</p><p>Example: <b><i>sites.org_name._fulltext=clinic</i></b> will find records with <i>org_name</i>: &#34;<i>Sanford <b>Clinic</b> North-Fargo</i>&#34; and &#34;<i>University of Kansas <b>Clinical</b> Research Center</i>&#34; - as the word &#34;<b>clinical</b>&#34; is a variation of the word &#34;<b>clinic</b>&#34;.</p><p>If you provide a multi-word value, it breaks the given value into words and apply an <b>\"and\"</b> condition regardless of order.</p><p>For example: <b>brief_title._fulltext=breast&#37;20cancer</b> will search for records with both &#34;<b>breast</b>&#34; and &#34;<b>cancer</b>&#34; in the brief_title field, in <b>any</b> order.</p><p><code>&lt;field_param&gt;._auto</code>: filter results by examining the beginning of each word for the given value.</p><p>Example: <b><i>lead_org._auto=roches</i></b> will find records with &#34;<i>University of <b>Roches</b>ter NCORP Research Base</i>&#34;.</p><p>Note: <b><i>lead_org._fulltext=roches</i></b> will find &#34;<i>Hoffmann-La <b>Roche</b></i>&#34; (because <b><i>roches</i></b> appears to be plural of <b><i>roche</i></b>), but will not find fields containing the word &#34;<b>Rochester</b>&#34;, because it's not a variation of &#34;<b>roches</b>&#34;.</p><p>Multi-word values are not broken into words. The exact given value is applied to the beginning of any word in the field, to create an \"autocomplete\" feature.</p><p><code>&lt;field_param&gt;._raw</code>: filter results by exact, case sensitive match of the field for the given value.</p><br><p>When supplying an array of values for a single filter param, please use the following convention: <code>trials?&lt;field_param&gt;=&lt;field_value_a&gt;&amp;&lt;field_param&gt;=&lt;field_value_b&gt;</code> and note that <code>string</code> field values are not case sensitive (must otherwise must match exactly).</p><p>Example: <font class=\"example\" color=\"#0000FF\" style=\"word-wrap: break-word;\">trials?sites.org_state_or_province=CA&amp;sites.org_state_or_province=OR</font></p><hr><h4 style='font-size: 15px; font-weight:bold;'>Prior Therapy Searches</h4><p> When searching in the <code>trials</code> Endpoint with multiple values for Prior Therapy, the following parameters in the API will treat the values as an <b>OR</b> condition and will return data that satisfies at least one of the condition being searched:  <b>inclusion_indicator, name, nci_thesaurus_concept_id, parents, synonyms, type, ancestor_ids </b><p><b>Example</b><ul><li> <b>prior_therapy.ancestor_ids</b>=C163758&<b>prior_therapy.ancestor_ids</b>=C471, API will return <b>ancestor_ids</b> = C163758 <b>OR ancestor_ids</b>=C471.</li><li><b>prior_therapy.inclusion_indicator</b>=TRIAL&<b>prior_therapy.inclusion_indicator</b>=TREE, API will return <b>inclusion_indicator</b> = TRIAL <b>OR inclusion_indicator</b>=TREE.</li><li><b>prior_therapy.parents</b>=C16725&<b>prior_therapy.parents</b>=C1909, API will return <b>parents</b> = C16725 <b>OR parents</b>=C1909.</li></ul></p><hr><h4 style='font-size: 15px; font-weight:bold;'>Date and Number Range Searches</h4><p>For field params which are filtering as ranges (<code>date</code> and <code>long</code> types), please supply <code>&#95;gte</code> or <code>&#95;lte</code> to the end of the field param (depending on if you are filtering on greater than or equal (gte), less than or equal (lte), or both):<br> <code>trials?&lt;field_param&gt;&#95;gte=&lt;field_value_from&gt;&amp;&lt;field_param&gt;&#95;lte=&lt;field_value_to&gt;</code></p><p>Example: <font class=\"example\" color=\"#0000FF\" style=\"word-wrap: break-word;\">trials?record_verification_date_gte=2016-08-25</font></p><hr><h4 style='font-size: 15px; font-weight:bold;'>Filtering Out Values</h4><p>Appending <code>&#95;not</code> to a parameter creates a <b>NOT</b> condition. Unlike normally (without the _not), where an OR condition is created, for <b>_not</b> parameters, multiple <b><field>_not</b> values of the same fields creates an <b>AND</b> condition between them.</p><p>             Example: <font class=\"example\" color=\"#0000FF\" style=\"word-wrap: break-word;\">trials?current_trial_status_not=Active&current_trial_status_not=Complete&nci_id_not=NCI-2017-01522</font></p><p>This request will return trials where (the current status is NOT Active AND current status is NOT Complete) AND nci_id is not NCI-2017-01522)</p><hr><h4 style='font-size: 15px; font-weight:bold;'>Embedded Searches</h4><p>Prepending <code>embed_and&#95;</code> creates a whole new search within a search to give you an embedded AND condition for all the parameters with the prepend. Up to 6 embedded searches are allowed.         </p><p>Example: <font class=\"example\" color=\"#0000FF\" style=\"word-wrap: break-word;\">trials?sites.org_country=Canada&keyword=Breast Cancer&<b>embed_and&#95;</b>keyword=OSU-14078&<b>embed_and&#95;</b>keyword_field=ccr_id&<b>embed_and&#95;</b>keyword_field=ctep_id&<b>embed_and&#95;</b>keyword_field=dcp_id &<b>embed_and&#95;</b>keyword_field=nci_id&<b>embed_and&#95;</b>keyword_field=nct_id&<b>embed_and&#95;</b>keyword_field=other_ids.value &<b>embed_and&#95;</b>keyword_field=protocol_id&<b>embed_and&#95;embed_and&#95;</b>sites.org_country=Uganda</font>          </p><p>In this search we have three searches (2 of them embedded) joined with an AND condition due to this embedment:</p><p>1. ...there is a match for the keyword search for Breast Cancer using our default configuration for keyword searches, and with a site in Canada.<br>AND<br>2. ...there is a match for the keyword search for OSU-14078 using a custom configuration of the keyword fields (rather than using the default)<br>AND<br>3. ... there is a site located in Uganda</p><hr><h4 style='font-size: 15px; font-weight:bold;'>Parallel Searches</h4><p>Prepending <code>outer_or&#95;</code> creates a whole new parallel search with an OR condition between the searches for all the parameters with the prepend. Up to 6 parallel searches are allowed.</p><p>Example:  <font class=\"example\" color=\"#0000FF\" style=\"word-wrap: break-word;\">trials?lead_org=Breast Cancer Institute&<b>outer_or&#95;</b>diseases.name.&#95;fulltext=Breast Cancer&<b>outer_or_outer_or&#95;</b>sites.org_name=Dana Breast Cancer Institute</font></p><p>In this search we have three parallel searches joined with an OR condition: </p><p>...the lead organization  is Breast Cancer Institute<br>OR<br>...the trial has a disease where the disease name  is Breast Cancer<br>OR<br>...one of the sites has org name “Dana Breast Cancer Institute”</p><hr><h4 style='font-size: 15px; font-weight:bold;'>Negating Searches</h4><p>Prepending <code>outer_not&#95;</code> creates a whole new search for all the parameters with the prepend and then negates the entire query or subquery. </p><p>Example:  <font class=\"example\" color=\"#0000FF\" style=\"word-wrap: break-word;\">trials?current_trial_status=ACTIVE&primary_purpose=TREATMENT&eligibility.structured.gender=BOTH&diseases.is_lead_disease=true&diseases.nci_thesaurus_concept_id=C4872&embed_and&#95;<b>outer_not&#95;</b>diseases.nci_thesaurus_concept_id=C71732&embed_and&#95;<b>outer_not&#95;</b>diseases.is_lead_disease=true&embed_and_embed_and&#95;<b>outer_not&#95;</b>diseases.nci_thesaurus_concept_id=C53556&embed_and_embed_and&#95;<b>outer_not&#95;</b>diseases.is_lead_disease=true</font></p><p>In this search: </p><p>...all the active trials with treatment as the primary purpose accepting both genders where breast cancer (C4872) is a lead disease, And where Triple-Negative Breast Cancer (C71732) is NOT a lead disease, And HER2 Positive Breast Carcinoma (C53556) is NOT a lead disease.</p><hr><h4 style='font-size: 15px; font-weight:bold;'>Disease Type Filters</h4><p>The disease elements in the trials have been tagged by one or more of five different types: <i>maintype, subtype, stage, grade and finding</i>. The API allows users to search by type.</p><p>Example: <font class=\"example\" color=\"#0000FF\" style=\"word-wrap: break-word;\">trials?include=none&grade=C9137&grade=C3641&maintype=C4872&maintype=C4878</font></p><p>This request will return trials with (Breast Cancer [C4872] OR Lung Cancer [C4878]) AND (Combined Small Cell Lung Cancer [C9137] OR Stage 0 Breast Cancer [C3641])</p><hr><h4 style='font-size: 15px; font-weight:bold;'>Field Aggregations</h4><p>Aggregations of fields is accomplished by parameter <b>agg_field</b> and supports progressive trials filtering</p><p>This functionality is only available at the trials end point. Trials results are given and as usual <b>total</b> and <b>data</b> always belong to the results of the <u>trials search</u>, and within that, Aggregations results are listed in the results under <b>“aggregations”</b> field under the trials results. All fields like <b>aggregations.doc_count</b>, refer to the aggregations.<ul><li>Without filters, <b>aggregations.doc_count</b> (referring to total in aggregations) and <b>total</b> (referring to total trials from which there are aggregations) will match. </li><li>With filters, there is no expectation that they should match, because you have further filtered after the aggregation.</li></ul></p><h4>Available Filters for Field Aggregations:</h4><p><b>agg_name</b>: If text…. Auto complete for key must match given value.  Note that this typeahead functionality is currently not available for the <b>anatomic_sites</b> field.<br><b>agg_min_count</b>:  doc_count for a given key must be a minimum of a given number amount (this filter will not lower key doc_count)</p><p>The \"size\" and \"from\" parameter enhancements for aggregations apply when: aggregations are requested for the trial endpoint, and the parameter \"include = none\" is specified. For this request, as before, no trial data is returned and CTS API will return the entire set of the aggregations as bound by the \"size\" and \"from\" parameters (if included in request).</p><p>If the aggregations' request is made for the trials endpoint and the include parameter is not included and/or specified to include data fields (e.g., include=nci_id) then the \"size\" and \"from\" parameters as before apply to the data returned rather than the aggregations.</p><h4>For Sorting Field Aggregations:</h4><p><b>agg_field_sort</b> Default set to 'name'. Currently works only for values <code>name</code> and <code>count</code>.<br><b>agg_field_order</b> Default set to 'asc' (alphabetical order) when agg_field_sort is not specified and defaulted to name. Otherwise currently works only for values <code>asc</code> and <code>desc</code>.</p><p>Example: /api/v2/trials?agg_field=lead_org&amp;current_trial_status=Active&amp;agg_name=Anderson&amp;include=nci_id&amp;size=1    <br>{     <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \"total\": 6180, &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &larr; <i>number of trials where the current trial status is Active</i>     <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \"data\": [{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &larr; <i>other data relating to trials from the trails filters</i> <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \"nci_id\": \"NCI-2015-01918\"&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }],     <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \"aggregations\": { &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &larr; <i>From 6180 trials we made aggregations and filtered to autocomplete lead_org of &ldquo;Anderson&rdquo;</i>     <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \"doc_count\": 491, &larr; <i># of trials where the current trial status is Active that meet the criteria of &ldquo;Anderson&rdquo; for aggregations</i>     <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \"lead_org\": [{ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &larr; <i>actual aggregations for lead org</i>     <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \"key\": \"M D Anderson Cancer Center\", &nbsp;&nbsp; &larr; <i>key that qualified for the filter</i>     <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \"doc_count\": 484 &nbsp;&nbsp; &larr; <i>actual trials count for lead org with key</i> <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \"key\": \"University of Texas MD Anderson Cancer Center LAO\", <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \"doc_count\": 7 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;] <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} <br>}</p><hr><h4 style='font-size: 15px; font-weight:bold;'>Default Sort Order of Trials</h4><p><ul><li>1) sort by the study type (interventional vs non-interventional) - interventional first</li><li>2) sort by the primary purpose (treatment, supportive care, etc) - there is a list of numbers that map to the type. These numbers are sorted ascending. Treatment is the first, so it will come first.<br><br>Primary purpose sort hash values:<ul><li>treatment = 0</li><li>supportive care = 1</li><li>screening = 2</li><li>prevention = 3</li><li>diagnostic = 4</li><li>device = 5</li><li>basic science = 6</li><li>health services research = 7</li><li>other = 8</li></ul></li><li>3) sort by trial status (active, enrolling by invitation, etc) - Same thing as primary purpose, there is a list of names to numbers - sorted ascending, so active comes first.<br><br>Trial status sort hash values:<ul><li>active = 0</li><li>enrolling by invitation = 1</li><li>in review = 2</li><li>approved = 3</li><li>temporarily closed to accrual = 4</li><li>temporarily closed to accrual and intervention = 5</li><li>closed to accrual and intervention = 6</li><li>closed to accrual = 7</li><li>administratively complete = 8</li><li>complete = 9</li><li>withdrawn = 10</li></ul></li><li>4) sort by location distance, nearest first (if one is entered)</li><li>5) sort by the number of active or enrolling locations - descending</li><li>6) sort by phase sort mapped values - ascending.<br><br>Phase sort hash values:<ul><li>III = 0</li><li>II_III = 1</li><li>II = 2</li><li>I_II = 3</li><li>I = 4</li><li>O = 5</li><li>IV = 6</li><li>NA = 7</li></ul></li><li>7) sort by a scoring function&#42; - descending</li><li>8) sort by nct id - descending</li></ul></p><hr><h4 style='font-size: 15px; font-weight:bold;'>Deprecations</h4><p><code>_fulltext</code>: DEPRECATED. Use <code>keyword</code> instead which is configured with the same fields by default.</p><p><code><field_param>_fulltext</code>: DEPRECATED. Use <code><field_param>._fulltext</code> where available, as described above.</p><p><code>_trialids</code>: DEPRECATED. Use <code>trial_ids</code></p><hr><p>Below are some <i>examples</i> of filters for trials and configurations of results.</p><p>If you are crafting more complicated queries, it might be best to use the <code>POST</code> endpoint of the same name.</p><hr>

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let size = 987 // Int | Limit the amount of results a supplied amount (default is 10, max is 50). Note that this parameter will be ignored when <code>export</code> parameter is passed. (optional)
let from = 987 // Int | Starting from nth position of results lineup. Start the results from a supplied starting point (default is 0). (optional)
let sort = "" // String | The 'Default Sort Order of Trials' described above, can be overwritten by this param which allows a sort by field. Sorting should be available on most fields as long as they are sortable (i.e not available on objects and list/array fields and fields with list/array parent).<br> Note here that by sorting with the following number fields: <ul><li>_study_protocol_type_sort_order</li><li>_primary_purpose_sort_order</li><li>_phase_sort_order</li><li>_current_trial_status_sort_order</li></ul>... allows the user to sort by number assigned to a value mapped, as described under the 'Default Sort Order of Trials' section, rather than sorting by alphabetical order of the string values which may have limited value to some. (optional)
let order = "" // String | Asc or Desc. Required when using <code>sort</code>. (optional)
let missing = "" // String | Filter by empty results (i.e by nulls, missing fields, empty array) (optional)
let exists = "" // String | Filter by opposite of missing, and search for existence of field with value (optional)
let include = "" // String | Include only the supplied filter param fields in all results (useful if you want to minimize the payload returned). Use multiple times to include multiple fields.<br> Value <b>DEFAULT</b> is a shortcut to include the following fields: nci_id, nct_id, brief_title, sites.org_name, sites.org_postal_code, eligibility.structured, current_trial_status, sites.org_va, sites.org_country, sites.org_state_or_province, sites.org_city, sites.org_coordinates, sites.recruitment_status and diseases. (optional)
let exclude = "" // String | Exclude the supplied filter param fields from all results (useful if you want most of the payload returned with the exception of a few fields). Use multiple times to exclude multiple fields. If using with <code>include</code> param, and values are found in both, fields in these values will be included in the results. (optional)
let export = "" // String | Export all query results into a file. The data will be available to download using a link that will arrive by email.<br>Supported formats are JSON (<b>export=json</b>) and Excel (<b>export=xls</b>).<br>Requires <code>email</code> parameter. See also optional <code>filename</code> parameter. Note that <code>size</code> parameter will be ignored during exports. (optional)
let email = "email_example" // String | Required when using <code>export</code> to indicate the email address for exported data. (optional)
let filename = "filename_example" // String | To be used with <code>export</code> to indicate the beginning of the file name for exported data.<br>If omitted, filename will start with <b>\"report\"</b>. (optional)
let fulltext = "fulltext_example" // String | DEPRECATED. Use <code>keyword</code> together with <code>keyword_field</code> instead. (optional)
let fieldParamFulltext = "fieldParamFulltext_example" // String | DEPRECATED. Use <code><field_param>._fulltext</code> where available, described above. (optional)
let trialids = "trialids_example" // String | DEPRECATED. Use <code>trial_ids</code> instead. (optional)
let trialIds = "" // String | Filter results by examining trial identifiers (ccr_id, ctep_id, dcp_id, nci_id, nct_id, other_ids.value, protocol_id).  Example: trials?trial_ids=nci-2011&trial_ids=NCT00 (optional)
let keyword = "" // String | Text to be searched in multiple fields. It can be combined with <code>keyword_field</code>.<br><br><code>keyword</code> filter results by examining a variety of text-based fields <i>(By default: &#42;_id, other_ids.value, diseases.name._fulltext, diseases.synonyms._fulltext, brief_title, brief_summary, official_title, detail_description, official_title, brief_title, brief_summary, diseases.name._fulltext, detail_description, sites.org_name._fulltext, collaborators.name._fulltext, principal_investigator._fulltext, sites.contact_name._fulltext, sites.org_city._fulltext, sites.org_state_or_province._fulltext, arms.interventions.name, arms.interventions.synonyms, biomarkers.name, biomarkers.synonyms, prior_therapy.name, prior_therapy.synonyms)</i>.<br><br>Mutiple <code>keyword</code>s (with a maximum of 10 allowed) will give you an OR condition of between values in all configured fields. (optional)
let keywordField = "" // String | Field(s) to be searched for the text provided in <code>keyword</code>. Use multiple times; once for each field to be searched. For example:<br><code>keyword_field=brief_title._fulltext&keyword_field=lead_org._auto</code>. Use <code>keyword_field</code> to override the default fields used by <code>keyword</code>. A maximum of 10 fields is currently allowed. (optional)
let aggField = "" // String | Field to be used for aggregation.  (optional)
let aggName = "" // String | Filter aggregation (use with <b>agg_field</b>). Autocomplete of this value must match the value of the field in <b>agg_field</b>. (optional)
let aggMinCount = 987 // Int | Filter aggregation (use with <b>agg_field</b>). The number of documents (<b>doc_count</b>) for a given key (<b>agg_field</b>) must be a minimum of a given number amount (this filter will not lower key doc_count). (optional)
let sitesOrgNameFulltext = "" // String | Filter results by examining words that make up organization name e.g 'Mayo'. (optional)
let trialStatus = "" // String | Possible value: OPEN  (Equivalent to:<br> <b>current_trial_status</b>=<b><i>active</i></b>&<b>current_trial_status</b>=<b><i>approved</i></b><br>&<b>current_trial_status</b>=<b><i>enrolling by invitation</i></b><br>&<b>current_trial_status</b>=<b><i>in review</i></b><br>&<b>current_trial_status</b>=<b><i>temporarily closed to accrual</i></b><br>&<b>current_trial_status</b>=<b><i>temporarily closed to accrual and intervention</i></b><br>&<b>sites.recruitment_status</b>=<b><i>active</i></b>&<b>sites.recruitment_status</b>=<b><i>approved</i></b><br>&<b>sites.recruitment_status</b>=<b><i>enrolling_by_invitation</i></b><br>&<b>sites.recruitment_status</b>=<b><i>in_review</i></b><br>&<b>sites.recruitment_status</b>=<b><i>temporarily_closed_to_accrual</i></b><br>&<b>record_verification_date_gte</b>=<i>&lt;date reflecting 2 years ago&gt;</i> ) <br><p>In other words, for a trial to be considered &quot;OPEN&quot;, <b>current_trial_status</b> must be one of:<ul><li>active</li><li>approved</li><li>enrolling by invitation</li><li>in review</li><li>temporarily closed to accrual</li><li>temporarily closed to accrual and intervention</li></ul>and <b>sites.recruitment_status</b> must be one of:<ul><li>active</li><li>approved</li><li>enrolling_by_invitation</li><li>in_review</li><li>temporarily_closed_to_accrual</li></ul></p><p>and <b>record_verification_date</b> must be a date within the past two years</p>Currently does <b>not</b> work in combination with:  <i>embed_and_</i> and <i>outer_or_</i> prepends. (optional)
let nciFunded = "" // String | Search by NCI funded (optional)
let nciId = "" // String | Search by NCI ID. (optional)
let nctId = "" // String | Search by NCT ID. (optional)
let protocolId = "" // String | Search by Protocol ID. (optional)
let ccrId = "ccrId_example" // String | Search by CCR ID.  (No examples available.) (optional)
let ctepId = "" // String | Search by CTEP ID (optional)
let dcpId = "dcpId_example" // String | Search by DCP ID.  (No examples available.) (optional)
let currentTrialStatus = "" // String |  (optional)
let phase = "" // String |  (optional)
let studyProtocolType = "" // String |  (optional)
let nciPrograms = "" // String |  (optional)
let briefTitle = "" // String |  (optional)
let briefSummary = "" // String |  (optional)
let officialTitle = "" // String |  (optional)
let primaryPurpose = "" // String |  (optional)
let acceptsHealthyVolunteersIndicator = "acceptsHealthyVolunteersIndicator_example" // String | DEPRECATED. Use <code>eligibility.structured.accepts_healthy_volunteers</code> instead. (optional)
let eligibilityStructuredAcceptsHealthyVolunteers = false // Bool |  (optional)
let acronym = "acronym_example" // String |  (optional)
let amendmentDate = "" // String |  (optional)
let anatomicSites = "" // String |  (optional)
let armsDescription = "" // String |  (optional)
let armsName = "" // String |  (optional)
let armsType = "" // String |  (optional)
let armsInterventionsNciThesaurusConceptId = "" // String |  (optional)
let armsInterventionsDescription = "" // String |  (optional)
let armsInterventionsName = "" // String |  (optional)
let armsInterventionsType = "" // String |  (optional)
let armsInterventionsSynonyms = "" // String |  (optional)
let associatedStudiesStudyId = "" // String |  (optional)
let associatedStudiesStudyIdType = "" // String |  (optional)
let eligibilityStructuredGender = "" // String |  (optional)
let eligibilityStructuredMinAgeInYearsLte = 987 // Int |  (optional)
let eligibilityStructuredMinAgeInYearsGte = 987 // Int |  (optional)
let eligibilityStructuredMaxAgeInYearsLte = 987 // Int |  (optional)
let eligibilityStructuredMaxAgeInYearsGte = 987 // Int |  (optional)
let eligibilityStructuredMinAgeUnit = "" // String |  (optional)
let eligibilityStructuredMinAgeNumberLte = 987 // Int |  (optional)
let eligibilityStructuredMinAgeNumberGte = 987 // Int |  (optional)
let eligibilityStructuredMaxAgeUnit = "" // String |  (optional)
let eligibilityStructuredMaxAgeNumberLte = 987 // Int |  (optional)
let eligibilityStructuredMaxAgeNumberGte = 987 // Int |  (optional)
let currentTrialStatusDateLte = "" // String |  (optional)
let currentTrialStatusDateGte = "" // String |  (optional)
let recordVerificationDateLte = "" // String |  (optional)
let recordVerificationDateGte = "" // String |  (optional)
let sitesOrgCoordinatesLat =  // Double | Organization's Latitude - for example: 43.7029. Geolocation Search only works to find sites in the United States. (optional)
let sitesOrgCoordinatesLon =  // Double | Organization's Longitude - for example: -72.2895. Geolocation Search only works to find sites in the United States. (optional)
let sitesOrgCoordinatesDist = "sitesOrgCoordinatesDist_example" // String | The radius around the provided zip code.  Accepts these units of measurements [NM, nmi, nauticalmiles, mi, miles, yd, yards, ft, feet, in, inch, km, kilometers, cm, centimeters, mm, milimeters, m, meters].  If not provided defaults to 25mi.<br></br><b>Use of invalid postal codes, or non-US postal codes will return a 400 error.</b> (optional)
let sitesContactEmail = "sitesContactEmail_example" // String |  (optional)
let sitesContactName = "" // String |  (optional)
let sitesContactNameAuto = "" // String |  (optional)
let sitesContactNameRaw = "" // String |  (optional)
let sitesContactPhone = "sitesContactPhone_example" // String |  (optional)
let sitesOrgAddressLine1 = "sitesOrgAddressLine1_example" // String |  (optional)
let sitesOrgAddressLine2 = "" // String |  (optional)
let sitesOrgCity = "" // String |  (optional)
let sitesOrgPostalCode = "" // String |  (optional)
let sitesOrgStateOrProvince = "" // String |  (optional)
let sitesOrgCountry = "" // String |  (optional)
let sitesOrgCountryRaw = "" // String | Country name (case sensitive) (optional)
let sitesOrgEmail = "sitesOrgEmail_example" // String |  (optional)
let sitesOrgFamily = "" // String |  (optional)
let sitesOrgFax = "sitesOrgFax_example" // String |  (optional)
let sitesOrgName = "" // String |  (optional)
let sitesOrgNameAuto = "" // String |  (optional)
let sitesOrgNameRaw = "" // String |  (optional)
let sitesOrgPhone = "sitesOrgPhone_example" // String |  (optional)
let sitesRecruitmentStatus = "" // String |  (optional)
let sitesRecruitmentStatusDate = "" // String |  (optional)
let sitesRecruitmentStatusDateLte = "" // String |  (optional)
let sitesRecruitmentStatusDateGte = "" // String |  (optional)
let leadOrgCancerCenter = "" // String | Search by Lead Org Cancer Center (optional)

// Search Trials by GET
TrialsAPI.searchTrialsByGet(size: size, from: from, sort: sort, order: order, missing: missing, exists: exists, include: include, exclude: exclude, export: export, email: email, filename: filename, fulltext: fulltext, fieldParamFulltext: fieldParamFulltext, trialids: trialids, trialIds: trialIds, keyword: keyword, keywordField: keywordField, aggField: aggField, aggName: aggName, aggMinCount: aggMinCount, sitesOrgNameFulltext: sitesOrgNameFulltext, trialStatus: trialStatus, nciFunded: nciFunded, nciId: nciId, nctId: nctId, protocolId: protocolId, ccrId: ccrId, ctepId: ctepId, dcpId: dcpId, currentTrialStatus: currentTrialStatus, phase: phase, studyProtocolType: studyProtocolType, nciPrograms: nciPrograms, briefTitle: briefTitle, briefSummary: briefSummary, officialTitle: officialTitle, primaryPurpose: primaryPurpose, acceptsHealthyVolunteersIndicator: acceptsHealthyVolunteersIndicator, eligibilityStructuredAcceptsHealthyVolunteers: eligibilityStructuredAcceptsHealthyVolunteers, acronym: acronym, amendmentDate: amendmentDate, anatomicSites: anatomicSites, armsDescription: armsDescription, armsName: armsName, armsType: armsType, armsInterventionsNciThesaurusConceptId: armsInterventionsNciThesaurusConceptId, armsInterventionsDescription: armsInterventionsDescription, armsInterventionsName: armsInterventionsName, armsInterventionsType: armsInterventionsType, armsInterventionsSynonyms: armsInterventionsSynonyms, associatedStudiesStudyId: associatedStudiesStudyId, associatedStudiesStudyIdType: associatedStudiesStudyIdType, eligibilityStructuredGender: eligibilityStructuredGender, eligibilityStructuredMinAgeInYearsLte: eligibilityStructuredMinAgeInYearsLte, eligibilityStructuredMinAgeInYearsGte: eligibilityStructuredMinAgeInYearsGte, eligibilityStructuredMaxAgeInYearsLte: eligibilityStructuredMaxAgeInYearsLte, eligibilityStructuredMaxAgeInYearsGte: eligibilityStructuredMaxAgeInYearsGte, eligibilityStructuredMinAgeUnit: eligibilityStructuredMinAgeUnit, eligibilityStructuredMinAgeNumberLte: eligibilityStructuredMinAgeNumberLte, eligibilityStructuredMinAgeNumberGte: eligibilityStructuredMinAgeNumberGte, eligibilityStructuredMaxAgeUnit: eligibilityStructuredMaxAgeUnit, eligibilityStructuredMaxAgeNumberLte: eligibilityStructuredMaxAgeNumberLte, eligibilityStructuredMaxAgeNumberGte: eligibilityStructuredMaxAgeNumberGte, currentTrialStatusDateLte: currentTrialStatusDateLte, currentTrialStatusDateGte: currentTrialStatusDateGte, recordVerificationDateLte: recordVerificationDateLte, recordVerificationDateGte: recordVerificationDateGte, sitesOrgCoordinatesLat: sitesOrgCoordinatesLat, sitesOrgCoordinatesLon: sitesOrgCoordinatesLon, sitesOrgCoordinatesDist: sitesOrgCoordinatesDist, sitesContactEmail: sitesContactEmail, sitesContactName: sitesContactName, sitesContactNameAuto: sitesContactNameAuto, sitesContactNameRaw: sitesContactNameRaw, sitesContactPhone: sitesContactPhone, sitesOrgAddressLine1: sitesOrgAddressLine1, sitesOrgAddressLine2: sitesOrgAddressLine2, sitesOrgCity: sitesOrgCity, sitesOrgPostalCode: sitesOrgPostalCode, sitesOrgStateOrProvince: sitesOrgStateOrProvince, sitesOrgCountry: sitesOrgCountry, sitesOrgCountryRaw: sitesOrgCountryRaw, sitesOrgEmail: sitesOrgEmail, sitesOrgFamily: sitesOrgFamily, sitesOrgFax: sitesOrgFax, sitesOrgName: sitesOrgName, sitesOrgNameAuto: sitesOrgNameAuto, sitesOrgNameRaw: sitesOrgNameRaw, sitesOrgPhone: sitesOrgPhone, sitesRecruitmentStatus: sitesRecruitmentStatus, sitesRecruitmentStatusDate: sitesRecruitmentStatusDate, sitesRecruitmentStatusDateLte: sitesRecruitmentStatusDateLte, sitesRecruitmentStatusDateGte: sitesRecruitmentStatusDateGte, leadOrgCancerCenter: leadOrgCancerCenter) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **size** | **Int** | Limit the amount of results a supplied amount (default is 10, max is 50). Note that this parameter will be ignored when &lt;code&gt;export&lt;/code&gt; parameter is passed. | [optional] 
 **from** | **Int** | Starting from nth position of results lineup. Start the results from a supplied starting point (default is 0). | [optional] 
 **sort** | **String** | The &#39;Default Sort Order of Trials&#39; described above, can be overwritten by this param which allows a sort by field. Sorting should be available on most fields as long as they are sortable (i.e not available on objects and list/array fields and fields with list/array parent).&lt;br&gt; Note here that by sorting with the following number fields: &lt;ul&gt;&lt;li&gt;_study_protocol_type_sort_order&lt;/li&gt;&lt;li&gt;_primary_purpose_sort_order&lt;/li&gt;&lt;li&gt;_phase_sort_order&lt;/li&gt;&lt;li&gt;_current_trial_status_sort_order&lt;/li&gt;&lt;/ul&gt;... allows the user to sort by number assigned to a value mapped, as described under the &#39;Default Sort Order of Trials&#39; section, rather than sorting by alphabetical order of the string values which may have limited value to some. | [optional] 
 **order** | **String** | Asc or Desc. Required when using &lt;code&gt;sort&lt;/code&gt;. | [optional] 
 **missing** | **String** | Filter by empty results (i.e by nulls, missing fields, empty array) | [optional] 
 **exists** | **String** | Filter by opposite of missing, and search for existence of field with value | [optional] 
 **include** | **String** | Include only the supplied filter param fields in all results (useful if you want to minimize the payload returned). Use multiple times to include multiple fields.&lt;br&gt; Value &lt;b&gt;DEFAULT&lt;/b&gt; is a shortcut to include the following fields: nci_id, nct_id, brief_title, sites.org_name, sites.org_postal_code, eligibility.structured, current_trial_status, sites.org_va, sites.org_country, sites.org_state_or_province, sites.org_city, sites.org_coordinates, sites.recruitment_status and diseases. | [optional] 
 **exclude** | **String** | Exclude the supplied filter param fields from all results (useful if you want most of the payload returned with the exception of a few fields). Use multiple times to exclude multiple fields. If using with &lt;code&gt;include&lt;/code&gt; param, and values are found in both, fields in these values will be included in the results. | [optional] 
 **export** | **String** | Export all query results into a file. The data will be available to download using a link that will arrive by email.&lt;br&gt;Supported formats are JSON (&lt;b&gt;export&#x3D;json&lt;/b&gt;) and Excel (&lt;b&gt;export&#x3D;xls&lt;/b&gt;).&lt;br&gt;Requires &lt;code&gt;email&lt;/code&gt; parameter. See also optional &lt;code&gt;filename&lt;/code&gt; parameter. Note that &lt;code&gt;size&lt;/code&gt; parameter will be ignored during exports. | [optional] 
 **email** | **String** | Required when using &lt;code&gt;export&lt;/code&gt; to indicate the email address for exported data. | [optional] 
 **filename** | **String** | To be used with &lt;code&gt;export&lt;/code&gt; to indicate the beginning of the file name for exported data.&lt;br&gt;If omitted, filename will start with &lt;b&gt;\&quot;report\&quot;&lt;/b&gt;. | [optional] 
 **fulltext** | **String** | DEPRECATED. Use &lt;code&gt;keyword&lt;/code&gt; together with &lt;code&gt;keyword_field&lt;/code&gt; instead. | [optional] 
 **fieldParamFulltext** | **String** | DEPRECATED. Use &lt;code&gt;&lt;field_param&gt;._fulltext&lt;/code&gt; where available, described above. | [optional] 
 **trialids** | **String** | DEPRECATED. Use &lt;code&gt;trial_ids&lt;/code&gt; instead. | [optional] 
 **trialIds** | **String** | Filter results by examining trial identifiers (ccr_id, ctep_id, dcp_id, nci_id, nct_id, other_ids.value, protocol_id).  Example: trials?trial_ids&#x3D;nci-2011&amp;trial_ids&#x3D;NCT00 | [optional] 
 **keyword** | **String** | Text to be searched in multiple fields. It can be combined with &lt;code&gt;keyword_field&lt;/code&gt;.&lt;br&gt;&lt;br&gt;&lt;code&gt;keyword&lt;/code&gt; filter results by examining a variety of text-based fields &lt;i&gt;(By default: &amp;#42;_id, other_ids.value, diseases.name._fulltext, diseases.synonyms._fulltext, brief_title, brief_summary, official_title, detail_description, official_title, brief_title, brief_summary, diseases.name._fulltext, detail_description, sites.org_name._fulltext, collaborators.name._fulltext, principal_investigator._fulltext, sites.contact_name._fulltext, sites.org_city._fulltext, sites.org_state_or_province._fulltext, arms.interventions.name, arms.interventions.synonyms, biomarkers.name, biomarkers.synonyms, prior_therapy.name, prior_therapy.synonyms)&lt;/i&gt;.&lt;br&gt;&lt;br&gt;Mutiple &lt;code&gt;keyword&lt;/code&gt;s (with a maximum of 10 allowed) will give you an OR condition of between values in all configured fields. | [optional] 
 **keywordField** | **String** | Field(s) to be searched for the text provided in &lt;code&gt;keyword&lt;/code&gt;. Use multiple times; once for each field to be searched. For example:&lt;br&gt;&lt;code&gt;keyword_field&#x3D;brief_title._fulltext&amp;keyword_field&#x3D;lead_org._auto&lt;/code&gt;. Use &lt;code&gt;keyword_field&lt;/code&gt; to override the default fields used by &lt;code&gt;keyword&lt;/code&gt;. A maximum of 10 fields is currently allowed. | [optional] 
 **aggField** | **String** | Field to be used for aggregation.  | [optional] 
 **aggName** | **String** | Filter aggregation (use with &lt;b&gt;agg_field&lt;/b&gt;). Autocomplete of this value must match the value of the field in &lt;b&gt;agg_field&lt;/b&gt;. | [optional] 
 **aggMinCount** | **Int** | Filter aggregation (use with &lt;b&gt;agg_field&lt;/b&gt;). The number of documents (&lt;b&gt;doc_count&lt;/b&gt;) for a given key (&lt;b&gt;agg_field&lt;/b&gt;) must be a minimum of a given number amount (this filter will not lower key doc_count). | [optional] 
 **sitesOrgNameFulltext** | **String** | Filter results by examining words that make up organization name e.g &#39;Mayo&#39;. | [optional] 
 **trialStatus** | **String** | Possible value: OPEN  (Equivalent to:&lt;br&gt; &lt;b&gt;current_trial_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;active&lt;/i&gt;&lt;/b&gt;&amp;&lt;b&gt;current_trial_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;approved&lt;/i&gt;&lt;/b&gt;&lt;br&gt;&amp;&lt;b&gt;current_trial_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;enrolling by invitation&lt;/i&gt;&lt;/b&gt;&lt;br&gt;&amp;&lt;b&gt;current_trial_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;in review&lt;/i&gt;&lt;/b&gt;&lt;br&gt;&amp;&lt;b&gt;current_trial_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;temporarily closed to accrual&lt;/i&gt;&lt;/b&gt;&lt;br&gt;&amp;&lt;b&gt;current_trial_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;temporarily closed to accrual and intervention&lt;/i&gt;&lt;/b&gt;&lt;br&gt;&amp;&lt;b&gt;sites.recruitment_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;active&lt;/i&gt;&lt;/b&gt;&amp;&lt;b&gt;sites.recruitment_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;approved&lt;/i&gt;&lt;/b&gt;&lt;br&gt;&amp;&lt;b&gt;sites.recruitment_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;enrolling_by_invitation&lt;/i&gt;&lt;/b&gt;&lt;br&gt;&amp;&lt;b&gt;sites.recruitment_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;in_review&lt;/i&gt;&lt;/b&gt;&lt;br&gt;&amp;&lt;b&gt;sites.recruitment_status&lt;/b&gt;&#x3D;&lt;b&gt;&lt;i&gt;temporarily_closed_to_accrual&lt;/i&gt;&lt;/b&gt;&lt;br&gt;&amp;&lt;b&gt;record_verification_date_gte&lt;/b&gt;&#x3D;&lt;i&gt;&amp;lt;date reflecting 2 years ago&amp;gt;&lt;/i&gt; ) &lt;br&gt;&lt;p&gt;In other words, for a trial to be considered &amp;quot;OPEN&amp;quot;, &lt;b&gt;current_trial_status&lt;/b&gt; must be one of:&lt;ul&gt;&lt;li&gt;active&lt;/li&gt;&lt;li&gt;approved&lt;/li&gt;&lt;li&gt;enrolling by invitation&lt;/li&gt;&lt;li&gt;in review&lt;/li&gt;&lt;li&gt;temporarily closed to accrual&lt;/li&gt;&lt;li&gt;temporarily closed to accrual and intervention&lt;/li&gt;&lt;/ul&gt;and &lt;b&gt;sites.recruitment_status&lt;/b&gt; must be one of:&lt;ul&gt;&lt;li&gt;active&lt;/li&gt;&lt;li&gt;approved&lt;/li&gt;&lt;li&gt;enrolling_by_invitation&lt;/li&gt;&lt;li&gt;in_review&lt;/li&gt;&lt;li&gt;temporarily_closed_to_accrual&lt;/li&gt;&lt;/ul&gt;&lt;/p&gt;&lt;p&gt;and &lt;b&gt;record_verification_date&lt;/b&gt; must be a date within the past two years&lt;/p&gt;Currently does &lt;b&gt;not&lt;/b&gt; work in combination with:  &lt;i&gt;embed_and_&lt;/i&gt; and &lt;i&gt;outer_or_&lt;/i&gt; prepends. | [optional] 
 **nciFunded** | **String** | Search by NCI funded | [optional] 
 **nciId** | **String** | Search by NCI ID. | [optional] 
 **nctId** | **String** | Search by NCT ID. | [optional] 
 **protocolId** | **String** | Search by Protocol ID. | [optional] 
 **ccrId** | **String** | Search by CCR ID.  (No examples available.) | [optional] 
 **ctepId** | **String** | Search by CTEP ID | [optional] 
 **dcpId** | **String** | Search by DCP ID.  (No examples available.) | [optional] 
 **currentTrialStatus** | **String** |  | [optional] 
 **phase** | **String** |  | [optional] 
 **studyProtocolType** | **String** |  | [optional] 
 **nciPrograms** | **String** |  | [optional] 
 **briefTitle** | **String** |  | [optional] 
 **briefSummary** | **String** |  | [optional] 
 **officialTitle** | **String** |  | [optional] 
 **primaryPurpose** | **String** |  | [optional] 
 **acceptsHealthyVolunteersIndicator** | **String** | DEPRECATED. Use &lt;code&gt;eligibility.structured.accepts_healthy_volunteers&lt;/code&gt; instead. | [optional] 
 **eligibilityStructuredAcceptsHealthyVolunteers** | **Bool** |  | [optional] 
 **acronym** | **String** |  | [optional] 
 **amendmentDate** | **String** |  | [optional] 
 **anatomicSites** | **String** |  | [optional] 
 **armsDescription** | **String** |  | [optional] 
 **armsName** | **String** |  | [optional] 
 **armsType** | **String** |  | [optional] 
 **armsInterventionsNciThesaurusConceptId** | **String** |  | [optional] 
 **armsInterventionsDescription** | **String** |  | [optional] 
 **armsInterventionsName** | **String** |  | [optional] 
 **armsInterventionsType** | **String** |  | [optional] 
 **armsInterventionsSynonyms** | **String** |  | [optional] 
 **associatedStudiesStudyId** | **String** |  | [optional] 
 **associatedStudiesStudyIdType** | **String** |  | [optional] 
 **eligibilityStructuredGender** | **String** |  | [optional] 
 **eligibilityStructuredMinAgeInYearsLte** | **Int** |  | [optional] 
 **eligibilityStructuredMinAgeInYearsGte** | **Int** |  | [optional] 
 **eligibilityStructuredMaxAgeInYearsLte** | **Int** |  | [optional] 
 **eligibilityStructuredMaxAgeInYearsGte** | **Int** |  | [optional] 
 **eligibilityStructuredMinAgeUnit** | **String** |  | [optional] 
 **eligibilityStructuredMinAgeNumberLte** | **Int** |  | [optional] 
 **eligibilityStructuredMinAgeNumberGte** | **Int** |  | [optional] 
 **eligibilityStructuredMaxAgeUnit** | **String** |  | [optional] 
 **eligibilityStructuredMaxAgeNumberLte** | **Int** |  | [optional] 
 **eligibilityStructuredMaxAgeNumberGte** | **Int** |  | [optional] 
 **currentTrialStatusDateLte** | **String** |  | [optional] 
 **currentTrialStatusDateGte** | **String** |  | [optional] 
 **recordVerificationDateLte** | **String** |  | [optional] 
 **recordVerificationDateGte** | **String** |  | [optional] 
 **sitesOrgCoordinatesLat** | **Double** | Organization&#39;s Latitude - for example: 43.7029. Geolocation Search only works to find sites in the United States. | [optional] 
 **sitesOrgCoordinatesLon** | **Double** | Organization&#39;s Longitude - for example: -72.2895. Geolocation Search only works to find sites in the United States. | [optional] 
 **sitesOrgCoordinatesDist** | **String** | The radius around the provided zip code.  Accepts these units of measurements [NM, nmi, nauticalmiles, mi, miles, yd, yards, ft, feet, in, inch, km, kilometers, cm, centimeters, mm, milimeters, m, meters].  If not provided defaults to 25mi.&lt;br&gt;&lt;/br&gt;&lt;b&gt;Use of invalid postal codes, or non-US postal codes will return a 400 error.&lt;/b&gt; | [optional] 
 **sitesContactEmail** | **String** |  | [optional] 
 **sitesContactName** | **String** |  | [optional] 
 **sitesContactNameAuto** | **String** |  | [optional] 
 **sitesContactNameRaw** | **String** |  | [optional] 
 **sitesContactPhone** | **String** |  | [optional] 
 **sitesOrgAddressLine1** | **String** |  | [optional] 
 **sitesOrgAddressLine2** | **String** |  | [optional] 
 **sitesOrgCity** | **String** |  | [optional] 
 **sitesOrgPostalCode** | **String** |  | [optional] 
 **sitesOrgStateOrProvince** | **String** |  | [optional] 
 **sitesOrgCountry** | **String** |  | [optional] 
 **sitesOrgCountryRaw** | **String** | Country name (case sensitive) | [optional] 
 **sitesOrgEmail** | **String** |  | [optional] 
 **sitesOrgFamily** | **String** |  | [optional] 
 **sitesOrgFax** | **String** |  | [optional] 
 **sitesOrgName** | **String** |  | [optional] 
 **sitesOrgNameAuto** | **String** |  | [optional] 
 **sitesOrgNameRaw** | **String** |  | [optional] 
 **sitesOrgPhone** | **String** |  | [optional] 
 **sitesRecruitmentStatus** | **String** |  | [optional] 
 **sitesRecruitmentStatusDate** | **String** |  | [optional] 
 **sitesRecruitmentStatusDateLte** | **String** |  | [optional] 
 **sitesRecruitmentStatusDateGte** | **String** |  | [optional] 
 **leadOrgCancerCenter** | **String** | Search by Lead Org Cancer Center | [optional] 

### Return type

[**TrialResponse**](TrialResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchTrialsByPost**
```swift
    open class func searchTrialsByPost(body: AnyCodable, completion: @escaping (_ data: TrialResponse?, _ error: Error?) -> Void)
```

Search Trials by POST

<h3>POST trials</h3><p>Same as the <code>GET</code> endpoint, but allows you to craft a JSON body as the request.</p><p>Example:</p><code>curl -XPOST 'https://clinicaltrialsapi.cancer.gov/v2/trials' -H 'Content-Type: application/json' -d '{<br>\"sites.org_state_or_province\": [\"CA\", \"OR\"],<br>\"record_verification_date_gte\": \"2016-06-01\",<br>\"include\": [\"nci_id\"]<br> }'</code>

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let body = "TODO" // AnyCodable | Query in JSON format

// Search Trials by POST
TrialsAPI.searchTrialsByPost(body: body) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **AnyCodable** | Query in JSON format | 

### Return type

[**TrialResponse**](TrialResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

