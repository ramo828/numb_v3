import 'package:flutter/material.dart';

class Haqqinda extends StatelessWidget {
  static const String routeName = "/about";

  const Haqqinda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Haqqında",
          style: TextStyle(fontSize: 35, fontFamily: 'DizaynFont'),
        ),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: ListView(children: [
        const Text(
          """
      Flutter çapraz bir platformdur, aynı altyapıyı kullanarak hem IOS hemde Android tabanlı uygulamalar geliştirebilirsiniz.

Android ortamında yazılım geliştirme yapmak istiyorsanız En İyi 10 Android Geliştirme Ortamı isimli yazımızı inceleyebilirsiniz.

Flutter iki ana parçadan meydana geliyor;

SDK (Yazılım Geliştirme Kiti) : Uygulamalarınızı daha kolay geliştirebilmeniz için bir çok aracı hizmetinize sunar. SDK yazdığınız kodu hem IOS hemde Android için derleyebilmenizi sağlar
Framework (Bir çok UI ve kütüphaneler) : Yazılım geliştirirken kullanılan bir çok UI bileşeni (buttonlar, text inputlar v.b.) hizmetinize sunar. Bu bileşenleri projelerinize göre özelleştirebilirsiniz.
Flutter ile yazılım geliştirmesi yapabilmek için Dart adında bir programlama dili kullanılır. Dil Google tarafından Ekim 2011'de oluşturulmuş, her geçen yıl kendini geliştirerek yoluna devam etmiştir. 

Flutter’in en büyük rakibi Facebook’un geliştirmiş olduğu React Native teknolojisidir. İki teknoloji hakkında tüm detaylar için Flutter vs React Native – Bilmek İstediğiniz Her Şey isimli yazımızı inceleyebilirsiniz.

Eğer Flutter'ı bilgisayarınıza kurmak istiyorsanız Flutter Kurulumu Nasıl Yapılır? isimli yazımızı inceleyebilirsiniz.

Flutter hakkında daha detaylı bilgi almak için,
Flutter.dev.

Yazılımcıların Discord Kanalı

Dart Programlama Dili
Dart, ön uç (frontend) geliştirmeye odaklanır ve mobil ve web uygulamaları oluşturmak için kullanabilirsiniz. Hot Reload özelliği sayesinde kod üzerinde yaptığınız değişikliği hızlıca uygulama üzerinde görebilirsiniz. Buda yazılım geliştirme sürecini hızlandırır. 

Değişkenlerin veri türlerini açıkça belirtmeleri gerekmez. Ancak, bir fonksiyon oluşturduğunuzda parametrelerin veri türlerinin belirtilmiş olması gerekir. Her uygulamanın bir main () işlevi vardır ve hiçbir şey döndürmediğini belirtmek için void anahtar sözcüğüne sahiptir.

Biraz programlama bilginiz var ise, Dart yazılı bir nesne programlama dilidir. Dart'ın sözdizimini JavaScript’e benzer. 

Dart hakkında daha detaylı bilgi için,
Dart.dev

Neden Flutter Öğrenmek Gerekir?
Flutter kullanan firmalar

Flutter öğrenmek için bir çok neden vardır. Yukarıda flutter kullanarak geliştirme yapan bazı markaları görebilirsiniz. 

1. Kolay Öğrenilebilir
Flutter modern bir framewoktür. Mobil uygulamaları onunla geliştirmek çok kolaydır. Eğer daha önceden Java, Swift yada React Native kullandı iseniz Flutter’in ne kadar farklı olduğunu hemen anlayacaksınız.

2. Üretkenliği Artırır
Hot-Reload özelliği sayesinde kod üzerinde yaptığınız değişikliği aynı zamanda uygulamanız üzerinde görebilirsiniz. Bu özellik yazılım geliştirme sürecini ciddi şekilde hızlandırır ve üretkenliğinizi arttırır.

3. Girişimciler İçin İdealdir
Eğer fikrinizi hızlıca yatırımcılara göstermek istiyorsanız Flutter doğru bir teknolojidir. 

Flutter

Flutter kullanmak için 4 neden;

IOS ve Android için ayrıca yazılım geliştirme eforu gerektirmediği için maliyet avantajı sağlar.
Bir yazılım geliştiricinin ihtiyaç duyacağı herşeye sahiptir.
Native bir uygulamaya çok yakın uygulamalar geliştirebilirsiniz.
Flutter bir sürü aracı kullanımınıza sunar, bu araçları özelleştirerek çok güzel uygulamalar geliştirebilirsiniz.
Eğer girişimci iseniz sizin için faydalı olacağını düşündüğümüz Girişimcilerin Okuması Gereken 10 Altın Kitap isimli yazımızı okumanızı öneririz.

4. İyi Dökümantasyon
Yeni bir teknolojiye başlamak için iyi dökümantasyon çok önemlidir. Flutter'ın eğitim dökümanlarından çok şey öğrenebilirsiniz ve temel kullanım durumları için kolay örneklerle her şey çok ayrıntılıdır. 

5. Büyüyen Topluluk
Flutter kullanan büyük bir topluluk vardır. Buda bir sorun yaşadığınızda aradığınız yardımı çok kolay şekilde bulabileceğiniz anlamına geliyor. 

6. Android Studio ve VS Code Desteği
Flutter farklı IDE'lerde kullanılabilir. Bu teknoloji ile geliştirmek için iki ana kod düzenleyici Android Studio (IntelliJ) ve VS Code'dur.

Android Studio, her şey önceden entegre edilmiş eksiksiz bir yazılımdır. Başlamak için Flutter ve Dart eklentilerini indirmeniz gerekir.

Sonuç Olarak
Eğer mobil uygulama geliştirme konusunda kendinizi geliştirmek istiyor iseniz Flutter doğru bir başlangıç olacaktır. Hızlı öğrenebilme, büyük bir topluluk desteği ve sağladığı bir çok yararlı özellik sayesinde Flutter ile projelerinizi hızlıca hayata geçirebilirsiniz. 
      
      """,
          style: TextStyle(
            fontSize: 35,
            fontFamily: "dizaynFont",
          ),
        ),
      ]),
    );
  }
}
