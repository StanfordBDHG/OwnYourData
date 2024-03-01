# InterventionsAPI

All URIs are relative to *https://clinicaltrialsapi-int.cancer.gov/api/v2* <!-- markdown-link-check-disable-line -->

Method | HTTP request | Description
------------- | ------------- | -------------
[**searchInterventionsByGet**](InterventionsAPI.md#searchinterventionsbyget) | **GET** /interventions | Search Interventions by GET


# **searchInterventionsByGet**
```swift
    open class func searchInterventionsByGet(name: String? = nil, category: String? = nil, type: String? = nil, codes: String? = nil, include: String? = nil, sort: String? = nil, order: String? = nil, size: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Search Interventions by GET

<h3>GET interventions?&lt;filter_params&gt;</h3><p>The <code>interventions</code> endpoint is intended for typeaheads and other use cases where it is necessary to search for available interventions which can later be used to filter clinical trial results. Interventions are matched partially by supplying a string to the <code>name</code> field and may be filtered by other fields through parameters described below. Results are sorted by a combination of in alphabetical order by default i.e sort is set to name and order is set to asc.</p><p>Example <font class='example' color='#0000FF' style='word-wrap: break-word;'>interventions?category=agent%20category&name=Therapeutic</font></p><p><b>Progressive Filtering functionality:</b> All trial fields parameters described at the <b>/trials</b> endpoint are usable here to filter the trials from which you want to aggregate. For example, if you request <b>/interventions?maintype=C4872</b> this will give you all interventions that are in trials where Breast Cancer(C4872) is among the diseases in each trial. Note that <b>maintype</b> is a trials endpoint parameter related to <b>diseases.nci_thesaurus_concept_id</b>.</p><p>When searching  in the interventions Endpoint with multiple values for the following parameters (codes, category, type), API will treat values as an OR condition and will return data that contains one or the other that is being searched.</p><p><b>Examples</b><ul><li><b>codes</b>=C78203&<b>codes</b>=C141136, API will return <b>codes</b> = C78203 <b>OR codes</b> = C141136</li><li><b>category</b>=agent&<b>category</b>=agent%20category&&<b>category</b>=other, API will return <b>category</b> = agent <b>OR category</b> = agent category <b>OR category</b> = other</li><li><b>type</b>=drug&<b>type</b>=genetic, API will return <b>type</b> = drug <b>OR type</b> = genetic </li></ul></p><p><b>codes</b> and <b>code</b> parameters will be used interchangeably within CTS API V2</p><hr>

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let name = "" // String | Note that name checks for values assigned to name as well as values assigned to synonyms. (optional)
let category = "" // String |  (optional)
let type = "" // String |  (optional)
let codes = "" // String |  (optional)
let include = "" // String | Include only this field(s) in trials and exclude others. Use multiple times to include multiple fields.  (Useful if you want to minimize the payload returned) (optional)
let sort = "" // String | Default set to 'name'. Currently works only for <code>name</code> and <code>count</code>. (optional)
let order = "" // String | Asc or Desc. Required when using <code>sort</code>. (optional)
let size = 987 // Int | Not using the size parameter, by default, will give you ALL the results AND, in addition, will give you the 'total' field in the results, with the total count of the results. Once you do use the size parameter however, the number of results will be according to the size specified, AND, in addition, the 'total' field will not exist in your results. (optional)

// Search Interventions by GET
InterventionsAPI.searchInterventionsByGet(name: name, category: category, type: type, codes: codes, include: include, sort: sort, order: order, size: size) { (response, error) in
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
 **category** | **String** |  | [optional] 
 **type** | **String** |  | [optional] 
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

