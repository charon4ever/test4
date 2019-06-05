package logic.config;

public enum InterServiceEnum {
    TEST("T");

    private String internalServiceId;

    InterServiceEnum(String internalServiceId) {
        this.internalServiceId = internalServiceId;
    }

    public String getInternalServiceId() {
        return internalServiceId;
    }

    public void setInternalServiceId(String internalServiceId) {
        this.internalServiceId = internalServiceId;
    }
}
