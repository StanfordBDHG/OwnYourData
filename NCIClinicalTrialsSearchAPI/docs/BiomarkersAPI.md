# BiomarkersAPI

All URIs are relative to *https://clinicaltrialsapi-int.cancer.gov/api/v2* <!-- markdown-link-check-disable-line -->

Method | HTTP request | Description
------------- | ------------- | -------------
[**searchBiomarkersByGet**](BiomarkersAPI.md#searchbiomarkersbyget) | **GET** /biomarkers | Search Biomarkers by GET


# **searchBiomarkersByGet**
```swift
    open class func searchBiomarkersByGet(name: String? = nil, eligibilityCriterion: String? = nil, type: String? = nil, typeNot: String? = nil, parentIds: String? = nil, ancestorIds: String? = nil, codes: String? = nil, assayPurpose: String? = nil, semanticTypes: String? = nil, include: String? = nil, sort: String? = nil, order: String? = nil, size: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Search Biomarkers by GET

<h3>GET biomarkers?&lt;filter_params&gt;</h3><p>The <code>biomarkers</code> endpoint is intended for typeaheads and other use cases where it is necessary to search for available biomarkers which can later be used to filter clinical trial results. Biomarkers are matched partially by supplying a string to the <code>name</code> field and may be filtered by other fields through parameters described below. Results are sorted by a combination of in alphabetical order by default i.e sort is set to name and order is set to asc.</p><p>Example: <font class=\"example\" color=\"#0000FF\" style=\"word-wrap: break-word;\">biomarkers?eligibility_criterion=inclusion&name=estrogen</font></p><p><b>Progressive Filtering functionality:</b> All trial fields parameters described at the <b>/trials</b> endpoint are usable here to filter the trials from which you want to aggregate. For example, if you request <b>/biomarkers?maintype=C4872</b> this will give you all biomarkers that are in trials where Breast Cancer(C4872) is among the diseases in each trial. Note that <b>maintype</b> is a trials endpoint parameter related to <b>diseases.nci_thesaurus_concept_id</b>.</p><hr>

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let name = "" // String | Note that name checks for values assigned to name as well as values assigned to synonyms. (optional)
let eligibilityCriterion = "" // String | Eligibility criterion - inclusion or exclusion. (optional)
let type = "" // String | Type of Biomarker - Note that multiple values for type creates an 'OR' condition for the result set. Results will meet one of the type values requested. Use 'type' and 'type_not' together to further filter results. (optional)
let typeNot = "" // String | This will do the opposite of 'type' above and exclude rather than include. Note that multiple values for type creates an 'AND' condition for the result set. Results will meet all menu_not values requested. Use 'type' and 'type_not' together to further filter results. (optional)
let parentIds = "" // String | Setting the parent_id value will get you a direct child along a biomarker path. (optional)
let ancestorIds = "" // String | Setting an ancestor_ids value will get you any of the children along a biomarker path. (optional)
let codes = "" // String |  (optional)
let assayPurpose = "" // String | Why the biomarker is being measured (optional)
let semanticTypes = "semanticTypes_example" // String | Broad subject categories that provide a consistent categorization of all concepts represented (optional)
let include = "" // String | Include only this field(s) in trials and exclude others. Use multiple times to include multiple fields.  (Useful if you want to minimize the payload returned) (optional)
let sort = "" // String | Default set to 'name'. Currently works only for <code>name</code> and <code>count</code>. (optional)
let order = "" // String | Asc or Desc. Required when using <code>sort</code>. (optional)
let size = 987 // Int | Not using the size parameter, by default, will give you ALL the results AND, in addition, will give you the 'total' field in the results, with the total count of the results. Once you do use the size parameter however, the number of results will be according to the size specified, AND, in addition, the 'total' field will not exist in your results. (optional)

// Search Biomarkers by GET
BiomarkersAPI.searchBiomarkersByGet(name: name, eligibilityCriterion: eligibilityCriterion, type: type, typeNot: typeNot, parentIds: parentIds, ancestorIds: ancestorIds, codes: codes, assayPurpose: assayPurpose, semanticTypes: semanticTypes, include: include, sort: sort, order: order, size: size) { (response, error) in
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
 **name** | **String** | Note that name checks for values assigned to name as well as values assigned to synonyms. | [optional] 
 **eligibilityCriterion** | **String** | Eligibility criterion - inclusion or exclusion. | [optional] 
 **type** | **String** | Type of Biomarker - Note that multiple values for type creates an &#39;OR&#39; condition for the result set. Results will meet one of the type values requested. Use &#39;type&#39; and &#39;type_not&#39; together to further filter results. | [optional] 
 **typeNot** | **String** | This will do the opposite of &#39;type&#39; above and exclude rather than include. Note that multiple values for type creates an &#39;AND&#39; condition for the result set. Results will meet all menu_not values requested. Use &#39;type&#39; and &#39;type_not&#39; together to further filter results. | [optional] 
 **parentIds** | **String** | Setting the parent_id value will get you a direct child along a biomarker path. | [optional] 
 **ancestorIds** | **String** | Setting an ancestor_ids value will get you any of the children along a biomarker path. | [optional] 
 **codes** | **String** |  | [optional] 
 **assayPurpose** | **String** | Why the biomarker is being measured | [optional] 
 **semanticTypes** | **String** | Broad subject categories that provide a consistent categorization of all concepts represented | [optional] 
 **include** | **String** | Include only this field(s) in trials and exclude others. Use multiple times to include multiple fields.  (Useful if you want to minimize the payload returned) | [optional] 
 **sort** | **String** | Default set to &#39;name&#39;. Currently works only for &lt;code&gt;name&lt;/code&gt; and &lt;code&gt;count&lt;/code&gt;. | [optional] 
 **order** | **String** | Asc or Desc. Required when using &lt;code&gt;sort&lt;/code&gt;. | [optional] 
 **size** | **Int** | Not using the size parameter, by default, will give you ALL the results AND, in addition, will give you the &#39;total&#39; field in the results, with the total count of the results. Once you do use the size parameter however, the number of results will be according to the size specified, AND, in addition, the &#39;total&#39; field will not exist in your results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

