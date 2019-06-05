package logic.model.Exception;

public class NibException extends RuntimeException{
    private String internalServiceId;
    private NibErrorInfo errorInfo;

    public NibException(String internalServiceId, NibErrorInfo errorInfo) {
        this.internalServiceId = internalServiceId;
        this.errorInfo = errorInfo;
    }
}
