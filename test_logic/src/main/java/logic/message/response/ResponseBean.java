package logic.message.response;

import logic.model.Exception.NibException;

public class ResponseBean<T> {
    private String responseCode = "00";
    private String message = "";

    public ResponseBean() {
        //todo:如果不主动流式化，是否会报错
    }

    private T data = null;

    public ResponseBean(T data) {
        this.data = data;
    }

    public ResponseBean(Throwable e) {
        NibException error = (NibException) e;
        this.responseCode = error.getInternalServiceId() + error.getErrorInfo().getErrorCode();
        this.message = error.getErrorInfo().getErrorMessage();
    }


    public String getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(String responseCode) {
        this.responseCode = responseCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
