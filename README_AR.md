# إصلاح إعداد بناء APK لمشروع إدارة الشرائح

## الملفات التي يجب وضعها في المستودع
- `package.json`
- `capacitor.config.json`
- `.github/workflows/build-apk.yml`
- ملف الواجهة الحالي في `www/index.html`

## مهم: نقل الواجهة
ملف الواجهة الحالي في مستودع Charge موجود في الجذر باسم `index.html`، بينما Capacitor مضبوط على `webDir: "www"`.
أنشئ مجلد `www` وانسخ ملف `index.html` الحالي إليه باسم `www/index.html`.
احتفظ بنسخة الجذر مؤقتًا إلى أن تتأكد من نجاح البناء.

## بناء APK عبر GitHub
1. ارفع الملفات إلى المستودع.
2. افتح تبويب Actions.
3. شغّل `Build Android APK` من `Run workflow`، أو ادفع تحديثًا إلى الفرع.
4. بعد نجاح المهمة، افتح تشغيل الـ workflow وانزل إلى Artifacts.
5. نزّل `sim-inventory-debug-apk.zip`، فك الضغط، ثم ثبّت `app-debug.apk`.

## ملاحظات أمنية مهمة
- بيانات التطبيق محفوظة محليًا في `localStorage` وليست مشفرة تلقائيًا.
- لا تمسح بيانات التطبيق أو تحذفه قبل تصدير نسخة احتياطية من بياناتك.
- ملف Debug للتجربة. للتوزيع العام يلزم إعداد توقيع Release وحفظ مفتاح التوقيع بشكل آمن.
- لم تتم إضافة قفل PIN في هذه الحزمة؛ قفل الواجهة وحده لا يُعد تشفيرًا للبيانات.

## إجراء محلي سريع عبر Termux (اختياري)
بعد استنساخ المستودع في Termux، انقل `index.html` إلى `www/index.html`، ثم انسخ ملفات الإعداد هذه إلى جذور المسارات المذكورة، وبعدها:
```bash
npm install
npx cap add android
npx cap sync android
```
يتطلب بناء APK محليًا إعداد Android SDK وJava؛ الأسهل للهاتف هو GitHub Actions.
