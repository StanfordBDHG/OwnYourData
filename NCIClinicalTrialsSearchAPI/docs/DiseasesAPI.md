# DiseasesAPI

All URIs are relative to *https://clinicaltrialsapi.cancer.gov/api/v2*

Method | HTTP request | Description
------------- | ------------- | -------------
[**searchDiseasesByGet**](DiseasesAPI.md#searchdiseasesbyget) | **GET** /diseases | Search Diseases by GET


# **searchDiseasesByGet**
```swift
    open class func searchDiseasesByGet(name: String? = nil, type: String? = nil, typeNot: String? = nil, parentIds: String? = nil, ancestorIds: String? = nil, codes: String? = nil, include: String? = nil, sort: String? = nil, order: String? = nil, size: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Search Diseases by GET

<h3>GET diseases?&lt;filter_params&gt;</h3><p>The <code>diseases</code> endpoint is intended for typeaheads and other use cases where it is necessary to search for available diseases which can later be used to filter clinical trial results. Diseases are matched partially by supplying a string to the <code>name</code> field and may be filtered by other fields through parameters described below. Results are sorted by a combination of in alphabetical order by default i.e sort is set to name and order is set to asc.</p><p>Example: <font class='example' color='#0000FF' style='word-wrap: break-word;'>diseases?type_not=subtype&type=maintype&name=He</font></p><p><b>Progressive Filtering functionality:</b> All trial fields parameters described at the <b>/trials</b> endpoint are usable here to filter the trials from which you want to aggregate. For example, if you request <b>/diseases?maintype=C4872</b> this will give you all diseases that are in trials where Breast Cancer(C4872) is among the diseases in each trial. Note that <b>maintype</b> is a trials endpoint parameter related to <b>diseases.nci_thesaurus_concept_id</b>.</p><p>When searching  in the Diseases Endpoint with multiple values for the following parameters (codes, ancestor_ids, parent_ids, type), API will treat values as an OR condition and will return data that satisfies at least one of the condition being searched. </p><b>Examples</b><ul><li><b>codes</b>=C8285&<b>codes</b>=C8286, API will return <b>codes</b> = C8285 <b>OR codes</b> = C8286.</li><li><b>ancestor_ids</b>=C4878&<b>ancestor_ids</b>=C4912, API will return <b>ancestor_id</b> = C4878 <b>OR ancestor_ids</b> = C4912.</li><li><b>parent_ids</b>=C9039&<b>parent_ids</b>=C3099, API will return <b>parent_ids</b> = C9039 <b>OR parent_ids</b> = C3099.</li><li><b>type</b>=maintype&<b>type</b>=subtype, API will return <b>type</b> = maintype <b>OR type</b> = subtype</li></ul></p><p><b>codes</b> and <b>code</b> parameters will be used interchangeably within CTS API V2</p><hr>

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let name = "" // String | Note that name checks for values assigned to name as well as values assigned to synonyms. (optional)
let type = "" // String | Type of Disease - Note that multiple values for type creates an 'OR' condition for the result set. Results will meet one of the type values requested. Use 'type' and 'type_not' together to further filter results. (optional)
let typeNot = "" // String | This will do the opposite of 'type' above and exclude rather than include. Note that multiple values for type creates an 'AND' condition for the result set. Results will meet all menu_not values requested. Use 'type' and 'type_not' together to further filter results. (optional)
let parentIds = "" // String | Setting the parent_id value will get you a direct child along a disease path. (optional)
let ancestorIds = "" // String | Setting an ancestor_ids value will get you any of the children along a disease path. (optional)
let codes = "" // String |  (optional)
let include = "" // String | Include only this field(s) in trials and exclude others. Use multiple times to include multiple fields.  (Useful if you want to minimize the payload returned) (optional)
let sort = "" // String | Default set to 'name'. Currently works only for <code>name</code> and <code>count</code>. (optional)
let order = "" // String | Asc or Desc. Required when using <code>sort</code>. (optional)
let size = 987 // Int | Not using the size parameter, by default, will give you ALL the results AND, in addition, will give you the 'total' field in the results, with the total count of the results. Once you do use the size parameter however, the number of results will be according to the size specified, AND, in addition, the 'total' field will not exist in your results. (optional)

// Search Diseases by GET
DiseasesAPI.searchDiseasesByGet(name: name, type: type, typeNot: typeNot, parentIds: parentIds, ancestorIds: ancestorIds, codes: codes, include: include, sort: sort, order: order, size: size) { (response, error) in
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
 **type** | **String** | Type of Disease - Note that multiple values for type creates an &#39;OR&#39; condition for the result set. Results will meet one of the type values requested. Use &#39;type&#39; and &#39;type_not&#39; together to further filter results. | [optional] 
 **typeNot** | **String** | This will do the opposite of &#39;type&#39; above and exclude rather than include. Note that multiple values for type creates an &#39;AND&#39; condition for the result set. Results will meet all menu_not values requested. Use &#39;type&#39; and &#39;type_not&#39; together to further filter results. | [optional] 
 **parentIds** | **String** | Setting the parent_id value will get you a direct child along a disease path. | [optional] 
 **ancestorIds** | **String** | Setting an ancestor_ids value will get you any of the children along a disease path. | [optional] 
 **codes** | **String** |  | [optional] 
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

