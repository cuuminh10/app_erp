class FilterNameDashboard {

  static String FilterName (String moduleName)  {

    switch(moduleName) {
      case 'ProductionOrdr':
        return 'Job Ticket';
      case 'ProductionFG':
        return 'Production Result';
      case 'POPurchaseReceipt':
        return 'Good Receipt Request';
      case 'FGReceipt':
        return 'Good Receipt';
      case 'PR':
        return 'Purchase Request';
      case 'PO':
        return 'Purchase Order';
      default:
        return 'Approval Form';
    }
  }

  static String FilterImage (String moduleName)  {

    switch(moduleName) {
      case 'ProductionOrdr':
        return 'Jobticket.svg';
      case 'ProductionFG':
        return 'product-ressult.svg';
      case 'POPurchaseReceipt':
        return 'GoodReceiptRequest.svg';
      case 'FGReceipt':
        return 'Paper.svg';
      case 'PR':
        return 'Purchase_Request.svg';
      case 'PO':
        return 'purchase-order.svg';
      default:
        return 'Paper.svg';
    }
  }
}

