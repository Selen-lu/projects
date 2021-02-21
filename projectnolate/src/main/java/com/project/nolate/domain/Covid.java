package com.project.nolate.domain;

public class Covid {
	
	 private String gubun;
	   private String defCnt;
	   private String incDec;
	   private String isolClearCnt;
	   private String deathCnt;
	   private String qurRate;
	   private String stdDay;
	   private String createDt;
	   private String overFlowCnt;
	   private String localOccCnt;
	   public Covid(String gubun,String defCnt,String incDec,String isolClearCnt, String deathCnt,String qurRate,String stdDay,String createDt,String localOccCnt,String overFlowCnt) {
	      this.gubun =gubun;
	      this.defCnt=defCnt;
	      this.incDec=incDec;
	      this.isolClearCnt=isolClearCnt;
	      this.deathCnt=deathCnt;
	      this.qurRate=qurRate;
	      this.stdDay=stdDay;
	      this.createDt=createDt;
	   }
	   public Covid() {}
	   
	   
	   public String getGubun() {
	      return gubun;
	   }
	   public void setGubun(String gubun) {
	      this.gubun = gubun;
	   }
	   public String getDefCnt() {
	      return defCnt;
	   }
	   public void setDefCnt(String defCnt) {
	      this.defCnt = defCnt;
	   }
	   public String getIncDec() {
	      return incDec;
	   }
	   public void setIncDec(String incDec) {
	      this.incDec = incDec;
	   }
	   public String getIsolClearCnt() {
	      return isolClearCnt;
	   }
	   public void setIsolClearCnt(String isolClearCnt) {
	      this.isolClearCnt = isolClearCnt;
	   }
	   public String getDeathCnt() {
	      return deathCnt;
	   }
	   public void setDeathCnt(String deathCnt) {
	      this.deathCnt = deathCnt;
	   }
	   public String getQurRate() {
	      return qurRate;
	   }
	   public void setQurRate(String qurRate) {
	      this.qurRate = qurRate;
	   }
	   public String getStdDay() {
	      return stdDay;
	   }
	   public void setStdDay(String stdDay) {
	      this.stdDay = stdDay;
	   }
		public String getCreateDt() {
			return createDt;
		}
		public void setCreate_Dt(String createDt) {
			this.createDt = createDt;
		}
		public String getOverFlowCnt() {
			return overFlowCnt;
		}
		public void setOverFlowCnt(String overFlowCnt) {
			this.overFlowCnt = overFlowCnt;
		}
		public String getLocalOccCnt() {
			return localOccCnt;
		}
		public void setLocalOccCnt(String localOccCnt) {
			this.localOccCnt = localOccCnt;
		}

	   
	   
}
