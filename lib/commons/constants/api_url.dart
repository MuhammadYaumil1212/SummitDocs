class ApiUrl {
  static const baseUrl = "https://docssummit-api.humicprototyping.com/";
  static const apiV = 'api/';

  // Auth
  static const login = '${apiV}login';
  static const logout = '${apiV}logout';

  // configure admin
  static const listAdminIcodsa = "${apiV}admin/list/icodsa";
  static const listAdminIcicyta = "${apiV}admin/list/icicyta";
  static const listAllAdmin = "${apiV}admin/list";
  static const createIcodsa = "${apiV}admin/icodsa/create";
  static const createIcicyta = "${apiV}admin/icicyta/create";
  static const updateAdmin = "${apiV}admin/update/";
  static const deleteAdmin = "${apiV}admin/delete/";
  static const getAllUsers = "${apiV}admin/list";
  static const updateicicytaAdmin = "${apiV}icicyta/adminicicyta/update/";
  static const updateicodsaAdmin = "${apiV}icodsa/adminicodsa/update/";

  //virtual account
  static const getDataVirtualAccount = "${apiV}virtual-accounts/list";
  static const getDataVirtualAccountById = "${apiV}virtual-accounts/1/";
  static const createVirtualAccount = "${apiV}virtual-accounts/create";
  static const deleteVirtualAccount = "${apiV}/virtual-accounts/delete/";

  //bank transfer
  static const getAllListBank = "${apiV}bank-transfer/list";
  static const getListBankById = "${apiV}bank-transfer/list/";
  static const createBankTransfer = "${apiV}bank-transfer/create";
  static const deleteTransferBank = "${apiV}bank-transfer/delete/";

  //docs invoice
  static const getIcodsaInvoice = "${apiV}icodsa/invoices";
  static const updateIcodsaDataSuperAdmin = "${apiV}icodsa/invoices";
  static const updateDataIcodsa = "${apiV}icodsa/invoices/update/";

  //docs LOA

  //icicyta
  static const getDocsLOA = "${apiV}icicyta/loas";
  static const getDocsIDLOA = "${apiV}icicyta/loas/";
  static const postDataLoaIcicyta = "${apiV}icicyta/loas/create";

  //icodsa
  static const postDataLoaIcodsa = "${apiV}icodsa/loas/create";

  //docs signature
  static const getSignature = "${apiV}signature";
  static const getSignatureWithId = "${apiV}signatures/";
  static const createSignature = "${apiV}signatures/create";
}
