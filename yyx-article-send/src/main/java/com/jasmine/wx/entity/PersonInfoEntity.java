package com.jasmine.wx.entity;

import java.io.Serializable;
import java.util.Date;

public class PersonInfoEntity implements Serializable{
    private Long personId;

    private String personName;

    private String city;

    private String county;

    private String school;
    private String wschool;

    private String personClass;

    private String phone;

    private String state;

    private Date createTime;

    private Date updateTime;

    private String articleType;//图片作品类别

    private Long articleId;//作品编号

    private String cityId;
    private String cityName;
    private String countyId;
    private String countyName;
    private String schoolId;
    private String schoolName;

    private String sfileName;

    private String isUpdate;//是否修改已上传的文件



    public String getSfileName() {
		return sfileName;
	}

	public void setSfileName(String sfileName) {
		this.sfileName = sfileName;
	}

	public String getWschool() {
		return wschool;
	}

	public void setWschool(String wschool) {
		this.wschool = wschool;
	}

	public String getIsUpdate() {
		return isUpdate;
	}

	public void setIsUpdate(String isUpdate) {
		this.isUpdate = isUpdate;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getCountyId() {
		return countyId;
	}

	public void setCountyId(String countyId) {
		this.countyId = countyId;
	}

	public String getCountyName() {
		return countyName;
	}

	public void setCountyName(String countyName) {
		this.countyName = countyName;
	}

	public String getSchoolId() {
		return schoolId;
	}

	public void setSchoolId(String schoolId) {
		this.schoolId = schoolId;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public Long getArticleId() {
		return articleId;
	}

	public void setArticleId(Long articleId) {
		this.articleId = articleId;
	}

	public String getArticleType() {
		return articleType;
	}

	public void setArticleType(String articleType) {
		this.articleType = articleType;
	}

	public Long getPersonId() {
        return personId;
    }

    public void setPersonId(Long personId) {
        this.personId = personId;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getPersonClass() {
        return personClass;
    }

    public void setPersonClass(String personClass) {
        this.personClass = personClass;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}