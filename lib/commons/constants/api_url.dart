class ApiUrl {
  static const baseUrl = "";
  static const apiV = 'api/';

  // Auth
  static const login = '$baseUrl${apiV}login/';
  static const logout = '$baseUrl${apiV}logout/';

  // configure admin
  static const listAdminIcodsa = "$baseUrl${apiV}admin/list/icodsa/";
  static const listAdminIcicyta = "$baseUrl${apiV}admin/list/icicyta/";
  static const listAllAdmin = "$baseUrl${apiV}admin/list/";
  static const createIcodsa = "$baseUrl${apiV}admin/icodsa/create/";
  static const createIcicyta = "$baseUrl${apiV}admin/icicyta/create/";
  static const updateAdmin = "$baseUrl${apiV}admin/update/"; //add value 4/0/1..
  static const deleteAdmin = "$baseUrl${apiV}admin/delete/"; //add value 4/0/1..

  //virtual account
  static const getData = "$baseUrl${apiV}virtual-accounts/list/";
  static const getDataById = "$baseUrl${apiV}virtual-accounts/1/";
  static const createVirtualAccount = "$baseUrl${apiV}virtual-accounts/create/";
  static const updateVirtualAccount =
      "$baseUrl${apiV}virtual-accounts/update/"; //add value 4/0/1..

  //docs invoice
  static const getIcodsaInvoice = "$baseUrl${apiV}icodsa/invoices";
  static const updateIcodsaDataSuperAdmin = "$baseUrl${apiV}icodsa/invoices/";
  static const updateDataIcodsa = "$baseUrl${apiV}icodsa/invoices/update/";
  static const updateDataIcicyta = "$baseUrl${apiV}info?id=";
  static const deleteDataInvoices = "$baseUrl${apiV}info?id=";
  static const postDataInvoices = "$baseUrl${apiV}/info";

  //docs LOA
  static const getDocsLOA = "$baseUrl${apiV}info?id=";
  static const postDataIcodsa = "$baseUrl${apiV}icodsa/loas/create";
  static const postDataIcicyta = "$baseUrl${apiV}icicyta/loas/create";

  //docs receipt
  static const getDataReceipt = "$baseUrl${apiV}payments";

  //docs signature
  static const getSignature = "$baseUrl${apiV}signature";
  static const getSignatureWithId = "$baseUrl${apiV}signatures/";

  //docs
}
