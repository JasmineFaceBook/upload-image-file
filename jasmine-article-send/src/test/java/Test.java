import com.jasmine.wx.entity.PersonInfoEntity;
import com.jasmine.wx.utils.ListSortUtils;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

public class Test {
    @org.junit.Test
    public void test(){
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time="2021-01-09 12:00:00";
        String time1="2021-01-10 11:00:00";
        String time2="2021-01-11 10:00:00";

        List<PersonInfoEntity> list = new ArrayList<PersonInfoEntity>();
        PersonInfoEntity p = new PersonInfoEntity();
        p.setAge(27);
        p.setNum(3);
        try {
            p.setCreateTime(formatter.parse(time));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        p.setName("高小冷");
        p.setSeniority(4);
        p.setSex("男");

        PersonInfoEntity p2 = new PersonInfoEntity();
        p2.setAge(25);
        p2.setNum(1);
        try {
            p2.setCreateTime(formatter.parse(time1));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        p2.setName("高大冷");
        p2.setSeniority(4);
        p2.setSex("女");

        PersonInfoEntity p3 = new PersonInfoEntity();
        p3.setAge(27);
        p3.setNum(7);
        try {
            p3.setCreateTime(formatter.parse(time2));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        p3.setName("挺热的");
        p3.setSeniority(6);
        p3.setSex("男");

        list.add(p);
        list.add(p2);
        list.add(p3);

        //针对list多个属性排序,年龄相同则按照创建时间排序
        String[] sortNameArr = {"num", "createTime"};
        //true升序，false降序
        boolean[] isAscArr = {true, false};
        ListSortUtils.sort(list, sortNameArr, isAscArr);

        System.out.println(list.toString());

    }

    @org.junit.Test
    public void test1(){

        System.out.println("result:"+(Integer.MAX_VALUE - 8));
        List<String> userCars=new ArrayList<>();
        userCars.add("12,23");
        userCars.add("13,24");
        userCars.add("14,25");
        userCars.add("15,23");
        userCars.add("16,24");
        userCars.add("17,25");
        userCars=removeDupliByRecordId(userCars);
        for(String us:userCars){
            System.out.println("result:"+us);
        }


    }

    private List<String> removeDupliByRecordId(List<String> userCars) {
        List<String> names = new ArrayList<>();//用来临时存储person的id
        List<String> personList = userCars.stream().filter(// 过滤去重
                v -> {
                    String a[]=v.split(",");
                    boolean flag = !names.contains(a[1]);
                    names.add(a[1]);
                    return flag;
                }
        ).collect(Collectors.toList());
        return personList;
    }




    
}


   


