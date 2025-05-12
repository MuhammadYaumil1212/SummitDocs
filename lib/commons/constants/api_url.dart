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

  //icicyta
  static const getIcicytaInvoice = "${apiV}icicyta/invoices";
  static const updateIcicytaInvoice = "${apiV}icicyta/invoices/update/";

  //icodsa
  static const getIcodsaInvoice = "${apiV}icodsa/invoices";
  static const updateIcodsaInvoice = "${apiV}icodsa/invoices/update/";

  //docs LOA

  //icicyta
  static const getDocsLOA = "${apiV}icicyta/loas";
  static const getDocsIDLOA = "${apiV}icicyta/loas/";
  static const postDataLoaIcicyta = "${apiV}icicyta/loas/create";

  //icodsa
  static const postDataLoaIcodsa = "${apiV}icodsa/loas/create";
  static const getDocsIcodsaLoa = "${apiV}icodsa/loas";

  //docs signature
  static const getSignature = "${apiV}signatures";
  static const getSignatureWithId = "${apiV}signatures/";
  static const createSignature = "${apiV}signatures/create";
  static const deleteSignature = "${apiV}signatures/delete/";

  //receipt

  //icicyta
  static const getReceiptIcicyta = "${apiV}icicyta/payments";

  //icodsa
  static const getReceiptIcodsa = "${apiV}icodsa/payments";
}
