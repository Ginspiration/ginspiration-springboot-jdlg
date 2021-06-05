package jdlg.musicproject;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TestClass {
    public static void main(String[] args) {
        String str = "2515356169@qq.com";
        String str2 = "2515356169@qq.q2.com";
        String pattern = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";

        /**
         *  1、CharSequence 是 char 值的一个可读序列
         *  2、Pattern：指定为字符串的正则表达式必须首先被编译为此类的实例。
         *       然后，可将得到的模式用于创建 Matcher 对象，依照正则表达式，
         *       该对象可以与任意字符序列匹配。执行匹配所涉及的所有状态都驻留在匹配器中，所以多个匹配器可以共享同一模式。
         *  3、+ 可重复多次
         *    $  结尾不再匹配
         *    \\ 转义\
         */

        /*第一种：可以匹配多次*/
        //创建pattern，使得有一个匹配容器
        Pattern r = Pattern.compile(pattern);
        //创建本字符串匹配器，生成CharSequence只读char的序列
        Matcher m = r.matcher(str);
        Matcher m2 = r.matcher(str2);
        //开始匹配
        boolean flag = m.matches();
        boolean flag2 = m2.matches();

        System.out.println("结果1："+flag);
        System.out.println("结果2："+flag2);

        /*第二种，只匹配一次*/
        boolean b = Pattern.matches("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$", "69@qq.com");
        System.out.println("表达式："+pattern);
        System.out.println("输入："+str2);
        System.out.println("结果3："+b);
    }
}