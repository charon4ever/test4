package logic.model.Exception;

public class NibException extends RuntimeException{
    private String internalServiceId;
    private NibErrorInfo errorInfo;

    public NibException(String internalServiceId, NibErrorInfo errorInfo) {
        this.internalServiceId = internalServiceId;
        this.errorInfo = errorInfo;
    }

    public String getInternalServiceId() {
        return internalServiceId;
    }

    public void setInternalServiceId(String internalServiceId) {
        this.internalServiceId = internalServiceId;
    }

    public NibErrorInfo getErrorInfo() {
        return errorInfo;
    }

    public void setErrorInfo(NibErrorInfo errorInfo) {
        this.errorInfo = errorInfo;
    }
}
