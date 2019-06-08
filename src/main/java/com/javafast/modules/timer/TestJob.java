package com.javafast.modules.timer;

import org.apache.log4j.Logger;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.javafast.api.sms.utils.SmsUtils;

@Component
public class TestJob {

    private Logger logger = Logger.getLogger(TestJob.class);

    /**
     * 每30分钟执行一次
     */
    @Scheduled(cron = "0 0/30 * * * ?")
    public void test() {

        try {

            System.out.println("========定时任务开始=========");

            
            System.out.println("========定时任务结束=========");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
   
    //短信推送，每2分钟一次
    //@Scheduled(cron = "0 0/2 * * * ?")
    public void pushSms() {
        try {
            System.out.println("========推送短信 定时任务开始=========");
            SmsUtils.pushSms();
            System.out.println("========推送短信 定时任务结束=========");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
