package com.jasmine.wx.controller;

import com.jasmine.wx.entity.ArticleFileEntity;
import com.jasmine.wx.entity.PersonInfoEntity;
import com.jasmine.wx.service.ArticleService;
import com.jasmine.wx.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;

@Controller
@RequestMapping("/img")
public class PersonController {
    @Autowired(required = false)
    private PersonService personService;
    @Autowired(required = false)
    private ArticleService articleService;


    /***
     * @author: libingyao
     * @description: //TODO 文件上传
     * @date: 22:36 2020/3/14
     * @param: [personEntity, wjs, response, request, modelMaps]
     * @return: java.lang.Object
     **/
    @RequestMapping(value = "/upload", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object upLoadFile(PersonInfoEntity personEntity,
                             @RequestParam(value = "commonsMultipartFile", required = false) CommonsMultipartFile commonsMultipartFile,
                             HttpServletResponse response, HttpServletRequest request, ModelMap modelMaps) {
        Map<String, Object> modelMap = new HashMap<String, Object>();
        if (null == commonsMultipartFile) {
            modelMap.put("message", "上传失败，系统繁忙请稍候重试！");
            modelMap.put("flag", "6");
            return modelMap;

        }
        //查询这个人有没有上传过这个类型的图片
        Map<String, Object> mapM = new HashMap<String, Object>();
        mapM.put("personName", personEntity.getPersonName());
        mapM.put("phone", personEntity.getPhone());
        mapM.put("articleType", personEntity.getArticleType());
        List<PersonInfoEntity> ps = personService.selectByPrimaryKey(mapM);
        if (ps.size() > 0) {
            if (null != personEntity.getIsUpdate() && !"".equals(personEntity.getIsUpdate()) && "1".equals(personEntity.getIsUpdate())) {
                //获取城市的信息
                Map<String, Object> mapc = new HashMap<String, Object>();
                List<PersonInfoEntity> citylist = personService.getCity(mapc);
                modelMap.put("citylist", citylist);
                //获取这个城市对应的县
                Map<String, Object> mapu = new HashMap<String, Object>();
                mapu.put("cityId", personEntity.getCity());
                List<PersonInfoEntity> countylist = personService.getCounty(mapu);
                modelMap.put("countylist", countylist);
                //获取这个县对应的学校
                Map<String, Object> maps = new HashMap<String, Object>();
                maps.put("countyId", personEntity.getCounty());
                List<PersonInfoEntity> schoollist = personService.getSchool(maps);
                modelMap.put("schoollist", schoollist);

                modelMap.put("opersonName", personEntity.getPersonName());
                modelMap.put("ocity", personEntity.getCity());
                modelMap.put("ocounty", personEntity.getCounty());
                modelMap.put("oschool", personEntity.getSchool());
                if (null != personEntity.getWschool() && !"".equals(personEntity.getWschool())) {
                    modelMap.put("owschool", personEntity.getWschool());
                }
                modelMap.put("opersonClass", personEntity.getPersonClass());
                modelMap.put("ophone", personEntity.getPhone());
                modelMap.put("oarticleType", personEntity.getArticleType());
                modelMap.put("message", "您将修改已上传的报名信息!");
                modelMap.put("btnMessage", "确认修改作品");
                modelMap.put("flag", "1");
                modelMap.put("isUpdate", "2");
                return modelMap;
            } else {
                //修改人员信息
                personEntity.setPersonId(ps.get(0).getPersonId());
                personEntity.setState("1");
                personEntity.setUpdateTime(new Date());
                personService.updateByPrimaryKeySelective(personEntity);
                //修改文件
                ArticleFileEntity articleFileEntity = new ArticleFileEntity();
                //作品id
                articleFileEntity.setArticleId(ps.get(0).getArticleId());
                //人员id
                articleFileEntity.setPersonId(ps.get(0).getPersonId());
                try {

                    String fileName = new String(commonsMultipartFile.getOriginalFilename().getBytes("UTF-8"), "UTF-8");
                    articleFileEntity.setArticleName(fileName);
                    byte[] theFile = commonsMultipartFile.getBytes();
                    articleFileEntity.setArticleWj(theFile);
                    String fileUrl = upload(request, fileName, commonsMultipartFile, ps.get(0).getPersonId());
                    if (null != fileUrl && !"".equals(fileUrl)) {
                        articleFileEntity.setArticleUrl(fileUrl);
                    }
                    articleService.updateByPrimaryKeySelective(articleFileEntity);
                } catch (Exception e) {
                    e.printStackTrace();
                    modelMap.put("message", "上传失败");
                    modelMap.put("flag", "5");
                    return modelMap;
                }
                modelMap.put("message", "已上传的报名信息修改成功!");
                modelMap.put("flag", "2");
                modelMap.put("isUpdate", "1");
                return modelMap;
            }
        } else {
            //判断这个人有没有上传过图片
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("personName", personEntity.getPersonName());
            map.put("phone", personEntity.getPhone());
            List<PersonInfoEntity> p = personService.selectByPrimaryKey(map);
            //如果这个人已经存在
            if (p.size() > 0) {
                //只上传文件
                ArticleFileEntity articleFileEntity = new ArticleFileEntity();
                //作品类别
                articleFileEntity.setArticleType(personEntity.getArticleType());
                //状态
                articleFileEntity.setArticleState("1");
                //人员id
                articleFileEntity.setPersonId(p.get(0).getPersonId());
                //创建时间
                articleFileEntity.setCreateTime(new Date());
                try {

                    String fileName = new String(commonsMultipartFile.getOriginalFilename().getBytes("UTF-8"), "UTF-8");
                    articleFileEntity.setArticleName(fileName);
                    byte[] theFile = commonsMultipartFile.getBytes();
                    articleFileEntity.setArticleWj(theFile);
                    String fileUrl = upload(request, fileName, commonsMultipartFile, p.get(0).getPersonId());
                    if (null != fileUrl && !"".equals(fileUrl)) {
                        articleFileEntity.setArticleUrl(fileUrl);
                    }

                    articleService.insertSelective(articleFileEntity);
                } catch (Exception e) {
                    e.printStackTrace();
                    modelMap.put("message", "上传失败");
                    modelMap.put("flag", "5");
                    return modelMap;
                }
                modelMap.put("message", "再次提交成功");
                modelMap.put("btnMessage", "再次提交作品");
                modelMap.put("flag", "3");
                return modelMap;
            } else {
                //录入这个人的信息
                personEntity.setState("1");
               /* String pid=UUID.randomUUID().toString();
           	 personEntity.setPersonId(pid);*/
                personEntity.setCreateTime(new Date());
                personService.insertSelective(personEntity);
                //上传文件
                ArticleFileEntity articleFileEntity = new ArticleFileEntity();
                //作品类别
                articleFileEntity.setArticleType(personEntity.getArticleType());
                //状态
                articleFileEntity.setArticleState("1");
                //人员id
                articleFileEntity.setPersonId(personEntity.getPersonId());
                //创建时间
                articleFileEntity.setCreateTime(new Date());
                try {
      			/*ISO-8859-1*/
                    String fileName = new String(commonsMultipartFile.getOriginalFilename().getBytes("UTF-8"), "UTF-8");
                    System.out.println("file:" + fileName);
                    articleFileEntity.setArticleName(fileName);
                    byte[] theFile = commonsMultipartFile.getBytes();
                    articleFileEntity.setArticleWj(theFile);
                    String fileUrl = upload(request, fileName, commonsMultipartFile, personEntity.getPersonId());
                    if (null != fileUrl && !"".equals(fileUrl)) {
                        articleFileEntity.setArticleUrl(fileUrl);
                    }

                    articleService.insertSelective(articleFileEntity);
                } catch (Exception e) {
                    e.printStackTrace();
                    modelMap.put("message", "上传失败");
                    modelMap.put("flag", "5");
                    return modelMap;
                }

            }
            modelMap.put("message", "您已报名成功");
            modelMap.put("flag", "4");
            return modelMap;
        }


    }

    @RequestMapping(value = "/get/city", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<PersonInfoEntity> getCity(ModelMap modelMap) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<PersonInfoEntity> citylist = personService.getCity(map);
        modelMap.put("citylist", citylist);
        return citylist;

    }

    @RequestMapping(value = "/get/county", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<PersonInfoEntity> getCounty(ModelMap modelMap, PersonInfoEntity personEntity) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("cityId", personEntity.getCityId());
        List<PersonInfoEntity> countylist = personService.getCounty(map);
        modelMap.put("countylist", countylist);
        return countylist;
    }

    @RequestMapping(value = "/get/school", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<PersonInfoEntity> getSchool(ModelMap modelMap, PersonInfoEntity personEntity) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("countyId", personEntity.getCountyId());
        List<PersonInfoEntity> schoollist = personService.getSchool(map);
        modelMap.put("schoollist", schoollist);
        return schoollist;
    }


    /**
     * 上传文件并给文件重新命名
     *
     * @return
     */
    public String upload(HttpServletRequest request, String fileName, CommonsMultipartFile file, Long id) {

        try {
            //获取session对象
            HttpSession session = request.getSession();
            //获取Application对象
            ServletContext context = session.getServletContext();
            String ss = System.getProperty("user.dir");
            //获取真实路径
			/*context.getRealPath(ss+"/upload/img")*/
            String path = ss + "/upload/img";
            File saveDir = new File(path);
            if (!saveDir.exists())
                saveDir.mkdirs();
            // 将文件名字重新命名使上传的文件不会互相覆盖
            String newFileName = UUID.randomUUID().toString() + "_p" + id + fileName;
            // 将要上传的文件和路径都创建出来
            File newFile = new File(saveDir, newFileName);
            file.transferTo(newFile);
            return ss + "/upload/img/" + newFileName;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }

    }

}
