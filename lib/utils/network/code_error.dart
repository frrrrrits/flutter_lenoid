class CodeError extends Error {
  final int statusCode;
  final String message;
  final bool isNetworkError;

  CodeError(
    this.message, {
    this.statusCode = 0,
    this.isNetworkError = false,
  });

  @override
  String toString() {
    if (isNetworkError && message.isEmpty) {
      return statusCodeToString(statusCode);
    }
    return message;
  }

  String statusCodeToString(int statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad Request (400)";
      case 401:
        return "Unauthorized (401)";
      case 403:
        return "Forbidden (403)";
      case 404:
        return "Not Found (404)";
      case 500:
        return "Internal Server Error (500)";
      case 502:
        return "Bad Gateway (502)";
      case 503:
        return "Service Unavailable (503)";
      case 504:
        return "Gateway Timeout (504)";
      default:
        return "Connection Error, Status Code ($statusCode)";
    }
  }
}
