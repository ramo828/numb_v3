import 'dart:convert';

List<dynamic> loadData(String jsonData) => json.decode(jsonData).toList();

String token =
    "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJNQUlOIiwiZXhwIjoxNjY0MzY4MTE5fQ.Q-_nXJuPR-U5fZs_2ImB8W0avSrB9HqmkT8R0tpoNvq7ewwNY0vmOIvDPbTXrWDv_2YJBlC_kMjSmAZSNRoczg";

Map<String, String> header(String key) {
  return {
    'Content-Type': 'application/json',
    'Accept': 'application/json, text/plain, */*',
    'Authorization': key,
  };
}

Uri getBakcell(String number, String categoryKey, int page) {
  return Uri.https(
    "public-api.azerconnect.az",
    "/msbkcposappreservation/api/freemsisdn-nomre/search",
    {
      "msisdn": number,
      "categoryId": getCategory(categoryKey),
      "showReserved": "true",
      "size": "2000",
      "page": "$page",
    },
  );
}

String getCategory(String keyData) {
  Map<String, String> category = {
    "Sadə": "1429263300716842758",
    "Xüsusi 1": "1579692547752973099",
    "Xüsusi 2": "1579692503636523114",
    // 099
    "Sadə099": "1574940031138475856",
    "Bürünc": "1582551518546595643",
    "Gümüş": "1582551485948558941",
    "Qızıl": "1582551461421619154",
    "Platin": "1582551437850968791",
  };
  // ignore: unnecessary_null_comparison
  if (keyData == null) throw ("Null key");
  return category[keyData].toString();
}
