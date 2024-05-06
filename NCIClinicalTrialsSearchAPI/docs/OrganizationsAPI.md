# OrganizationsAPI

All URIs are relative to *https://clinicaltrialsapi.cancer.gov/api/v2*

Method | HTTP request | Description
------------- | ------------- | -------------
[**searchOrganizationsByGet**](OrganizationsAPI.md#searchorganizationsbyget) | **GET** /organizations | Search Organizations by GET


# **searchOrganizationsByGet**
```swift
    open class func searchOrganizationsByGet(name: String? = nil, contactName: String? = nil, contactEmail: String? = nil, contactPhone: String? = nil, orgAddressLine1: String? = nil, orgAddressLine2: String? = nil, orgCity: String? = nil, orgCountry: String? = nil, orgEmail: String? = nil, orgPhone: String? = nil, orgFax: String? = nil, orgTty: String? = nil, orgStateOrProvince: String? = nil, orgVa: String? = nil, orgPostalCode: String? = nil, orgFamily: String? = nil, orgCoordinatesLat: Double? = nil, orgCoordinatesLon: Double? = nil, orgCoordinatesDist: String? = nil, include: String? = nil, sort: String? = nil, order: String? = nil, size: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Search Organizations by GET

<h3>GET organizations?&lt;filter_params&gt;</h3><p>The <code>organizations</code> endpoint is intended for typeaheads and other use cases where it is necessary to search for available organizations which can later be used to filter clinical trial results. Organizations are matched partially by supplying a string to the <code>name</code> field and may be filtered by other fields through parameters described below. Results are sorted by a combination of in alphabetical order by default i.e sort is set to name and order is set to asc.</p><p>Example: <font class=\"example\" color=\"#0000FF\" style=\"word-wrap: break-word;\">organizations?org_city=Las Vegas&org_country=United States&name=University</font></p><p><b>Progressive Filtering functionality:</b> All trial fields parameters described at the <b>/trials</b> endpoint are usable here to filter the trials from which you want to aggregate. For example, if you request <b>/organizations?maintype=C4872</b> this will give you all organizations that are in trials where Breast Cancer(C4872) is among the diseases in each trial. Note that <b>maintype</b> is a trials endpoint parameter related to <b>diseases.nci_thesaurus_concept_id</b>.</p><hr>

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let name = "" // String |  (optional)
let contactName = "" // String |  (optional)
let contactEmail = "" // String |  (optional)
let contactPhone = "" // String |  (optional)
let orgAddressLine1 = "orgAddressLine1_example" // String |  (optional)
let orgAddressLine2 = "" // String |  (optional)
let orgCity = "" // String |  (optional)
let orgCountry = "" // String |  (optional)
let orgEmail = "" // String |  (optional)
let orgPhone = "" // String |  (optional)
let orgFax = "" // String |  (optional)
let orgTty = "" // String |  (optional)
let orgStateOrProvince = "" // String |  (optional)
let orgVa = "" // String |  (optional)
let orgPostalCode = "" // String |  (optional)
let orgFamily = "" // String |  (optional)
let orgCoordinatesLat =  // Double | Organization's Latitude - for example: 43.7029 (optional)
let orgCoordinatesLon =  // Double | Organization's Longitude - for example: -72.2895 (optional)
let orgCoordinatesDist = "orgCoordinatesDist_example" // String | The radius around a given geolocation. The geolocation can be provided by using both org_coordinates_lon and org_coordinates_lat, as described above, OR by specifying the zip code org_postal_code, at which point the geolocation will be calculated for you. We only support miles or kilometers for distance: for example org_coordinates_dist=25mi or org_coordinates_dist=25km. Geolocation Search only works to find sites in the United States. If not provided with geolocation parameters, currently defaults to 0.67mi to provide 'at location' results. (optional)
let include = "" // String | Include only this field(s) in trials and exclude others. Use multiple times to include multiple fields.  (Useful if you want to minimize the payload returned) (optional)
let sort = "" // String | Default set to 'name'. Currently works only for <code>name</code>. (optional)
let order = "" // String | Asc or Desc. Required when using <code>sort</code>. (optional)
let size = 987 // Int | Not using the size parameter, by default, will give you ALL the results AND, in addition, will give you the 'total' field in the results, with the total count of the results. Once you do use the size parameter however, the number of results will be according to the size specified, AND, in addition, the 'total' field will not exist in your results. (optional)

// Search Organizations by GET
OrganizationsAPI.searchOrganizationsByGet(name: name, contactName: contactName, contactEmail: contactEmail, contactPhone: contactPhone, orgAddressLine1: orgAddressLine1, orgAddressLine2: orgAddressLine2, orgCity: orgCity, orgCountry: orgCountry, orgEmail: orgEmail, orgPhone: orgPhone, orgFax: orgFax, orgTty: orgTty, orgStateOrProvince: orgStateOrProvince, orgVa: orgVa, orgPostalCode: orgPostalCode, orgFamily: orgFamily, orgCoordinatesLat: orgCoordinatesLat, orgCoordinatesLon: orgCoordinatesLon, orgCoordinatesDist: orgCoordinatesDist, include: include, sort: sort, order: order, size: size) { (response, error) in
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
 **name** | **String** |  | [optional] 
 **contactName** | **String** |  | [optional] 
 **contactEmail** | **String** |  | [optional] 
 **contactPhone** | **String** |  | [optional] 
 **orgAddressLine1** | **String** |  | [optional] 
 **orgAddressLine2** | **String** |  | [optional] 
 **orgCity** | **String** |  | [optional] 
 **orgCountry** | **String** |  | [optional] 
 **orgEmail** | **String** |  | [optional] 
 **orgPhone** | **String** |  | [optional] 
 **orgFax** | **String** |  | [optional] 
 **orgTty** | **String** |  | [optional] 
 **orgStateOrProvince** | **String** |  | [optional] 
 **orgVa** | **String** |  | [optional] 
 **orgPostalCode** | **String** |  | [optional] 
 **orgFamily** | **String** |  | [optional] 
 **orgCoordinatesLat** | **Double** | Organization&#39;s Latitude - for example: 43.7029 | [optional] 
 **orgCoordinatesLon** | **Double** | Organization&#39;s Longitude - for example: -72.2895 | [optional] 
 **orgCoordinatesDist** | **String** | The radius around a given geolocation. The geolocation can be provided by using both org_coordinates_lon and org_coordinates_lat, as described above, OR by specifying the zip code org_postal_code, at which point the geolocation will be calculated for you. We only support miles or kilometers for distance: for example org_coordinates_dist&#x3D;25mi or org_coordinates_dist&#x3D;25km. Geolocation Search only works to find sites in the United States. If not provided with geolocation parameters, currently defaults to 0.67mi to provide &#39;at location&#39; results. | [optional] 
 **include** | **String** | Include only this field(s) in trials and exclude others. Use multiple times to include multiple fields.  (Useful if you want to minimize the payload returned) | [optional] 
 **sort** | **String** | Default set to &#39;name&#39;. Currently works only for &lt;code&gt;name&lt;/code&gt;. | [optional] 
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

