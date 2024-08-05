package com.sellon.hr.common;


public class Constants {
    public enum ExceptionClass {
        EMPLOYEE("Employee"), ORDER("Order"), PROVIDER("Provider");

        private String exceptionClass;

        ExceptionClass(String exceptionClass) {
            this.exceptionClass = exceptionClass;
        }

        public String getExceptionClass() {
            return exceptionClass;
        }

        @Override
        public String toString() {
            return getExceptionClass() + " Exception : ";
        }
    }
}