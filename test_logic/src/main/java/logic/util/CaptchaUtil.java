package logic.util;

import com.github.bingoohuang.patchca.background.BackgroundFactory;
import com.github.bingoohuang.patchca.color.ColorFactory;
import com.github.bingoohuang.patchca.custom.ConfigurableCaptchaService;
import com.github.bingoohuang.patchca.filter.predefined.*;
import com.github.bingoohuang.patchca.utils.encoder.EncoderHelper;
import com.github.bingoohuang.patchca.word.RandomWordFactory;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

public class CaptchaUtil {
    private static ConfigurableCaptchaService cs = new ConfigurableCaptchaService();
    private static Random random = new Random();

    static {
        cs.setColorFactory(new ColorFactory() {
            public Color getColor(int x) {
                int[] c = new int[3];
                int i = random.nextInt(c.length);
                for (int fi = 0; fi < c.length; fi++) {
                    if (fi == i) {
                        c[fi] = random.nextInt(71);
                    } else {
                        c[fi] = random.nextInt(256);
                    }
                }
                return new Color(c[0], c[1], c[2]);
            }
        });
        cs.setBackgroundFactory(new BackgroundFactory() {
            public void fillBackground(BufferedImage bufferedImage) {
                Graphics graphics = bufferedImage.getGraphics();
                // 验证码图片的宽高
                int imgWidth = bufferedImage.getWidth();
                int imgHeight = bufferedImage.getHeight();
                // 画100个噪点(颜色及位置随机)
                for (int i = 0; i < 100; i++) {
                    // 随机颜色
                    int rInt = random.nextInt(255);
                    int gInt = random.nextInt(255);
                    int bInt = random.nextInt(255);
                    graphics.setColor(new Color(rInt, gInt, bInt));
                    // 随机位置
                    int xInt = random.nextInt(imgWidth - 3);
                    int yInt = random.nextInt(imgHeight - 2);
                    // 随机旋转角度
                    int sAngleInt = random.nextInt(360);
                    int eAngleInt = random.nextInt(360);
                    // 随机大小
                    int wInt = random.nextInt(6);
                    int hInt = random.nextInt(6);
                    graphics.fillArc(xInt, yInt, wInt, hInt, sAngleInt, eAngleInt);
                    // 画5条干扰线
                    if (i % 20 == 0) {
                        int xInt2 = random.nextInt(imgWidth);
                        int yInt2 = random.nextInt(imgHeight);
                        graphics.drawLine(xInt, yInt, xInt2, yInt2);
                    }
                }
            }
        });
        RandomWordFactory wf = new RandomWordFactory();
        wf.setCharacters("23456789abcdefghigkmnpqrstuvwxyzABCDEFGHIGKLMNPQRSTUVWXYZ");
        wf.setMaxLength(4);
        wf.setMinLength(4);
        cs.setWordFactory(wf);
    }

    public static String generateCaptcha(OutputStream os) throws IOException {
        switch (random.nextInt(5)) {
            case 0:
                cs.setFilterFactory(new CurvesRippleFilterFactory(cs.getColorFactory()));
                break;
            case 1:
                cs.setFilterFactory(new MarbleRippleFilterFactory());
                break;
            case 2:
                cs.setFilterFactory(new DoubleRippleFilterFactory());
                break;
            case 3:
                cs.setFilterFactory(new WobbleRippleFilterFactory());
                break;
            case 4:
                cs.setFilterFactory(new DiffuseRippleFilterFactory());
                break;
        }
        return EncoderHelper.getChallangeAndWriteImage(cs, "png", os);
    }
}
