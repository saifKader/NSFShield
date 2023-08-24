var ip = "192.168.1.18";
//var ip = "localhost";
var kbaseUrl = 'http://$ip:9090/';

//url
const String loginEndpoint = '/login';
const String refreshEndpoint = '/refresh';
const String extractAccountNumberEndpoint = '/extract_account_number';
const String issueCheckEndpoint = '/issue_check';
const String checkTransactionsEndpoint = '/check_transactions';
const String pinEndpoint ='/send_pin_sms';