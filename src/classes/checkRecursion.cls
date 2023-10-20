public with sharing class checkRecursion {
  
  private static boolean firstRun = true;
  private static boolean firstRunA = true;
  private static boolean isFirstRunCPPH = true;
  
  public static boolean isFirstRun() {
    if(firstRun) {
      firstRun = false;
      return true;
    } else {
      return firstRun;
    }
    
  }
  
  public static void resetFirstRun() {
    firstRun = true;
  }
  public static boolean isFirstRunA() {
    if(firstRunA) {
      firstRunA = false;
      return true;
    } else {
      return firstRunA;
    }
    
  }
  
  public static void resetFirstRunA() {
    firstRunA = true;
  }
  
  public static boolean isFirstRunCPPH() {
    if(isFirstRunCPPH) {
      isFirstRunCPPH = false;
      return true;
    } else {
      return isFirstRunCPPH;
    }
    
  }
  
  public static void resetFirstRunCPPH() {
    isFirstRunCPPH = true;
  }
}