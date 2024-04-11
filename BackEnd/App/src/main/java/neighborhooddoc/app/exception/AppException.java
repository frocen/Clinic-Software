package neighborhooddoc.app.exception;

public class AppException extends Exception{

    private final Integer code;
    private final String message;
    public AppException(Integer code, String message){
        this.code =code;
        this.message = message;
    }
    public AppException(AppExceptionEnum exceptionEnum) {
        this(exceptionEnum.getCode(), exceptionEnum.getMsg());
    }
    public Integer getCode() {
        return code;
    }

    @Override
    public String getMessage() {
        return message;
    }

}
