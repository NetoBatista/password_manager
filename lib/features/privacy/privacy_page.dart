import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('privacy'.i18n()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(textKnowMore()),
            ],
          ),
        ),
      ),
    );
  }

  String textKnowMore() {
    if (Platform.localeName == "pt_BR") {
      return """
  Política Privacidade

  A sua privacidade é importante para nós. É política do Gerenciador de senha respeitar a sua privacidade em relação a qualquer informação sua que possamos coletar no site Gerenciador de senha, e outros sites que possuímos e operamos.

  Solicitamos informações pessoais apenas quando realmente precisamos delas para lhe fornecer um serviço. Fazemo-lo por meios justos e legais, com o seu conhecimento e consentimento. Também informamos por que estamos coletando e como será usado.

  Apenas retemos as informações coletadas pelo tempo necessário para fornecer o serviço solicitado. Quando armazenamos dados, protegemos dentro de meios comercialmente aceitáveis ​​para evitar perdas e roubos, bem como acesso, divulgação, cópia, uso ou modificação não autorizados.

  Não compartilhamos informações de identificação pessoal publicamente ou com terceiros, exceto quando exigido por lei.

  O nosso site pode ter links para sites externos que não são operados por nós. Esteja ciente de que não temos controle sobre o conteúdo e práticas desses sites e não podemos aceitar responsabilidade por suas respectivas políticas de privacidade.

  Você é livre para recusar a nossa solicitação de informações pessoais, entendendo que talvez não possamos fornecer alguns dos serviços desejados.

  O uso continuado de nosso site será considerado como aceitação de nossas práticas em torno de privacidade e informações pessoais. Se você tiver alguma dúvida sobre como lidamos com dados do usuário e informações pessoais, entre em contacto connosco.


  O serviço Google AdSense que usamos para veicular publicidade usa um cookie DoubleClick para veicular anúncios mais relevantes em toda a Web e limitar o número de vezes que um determinado anúncio é exibido para você.
  Para mais informações sobre o Google AdSense, consulte as FAQs oficiais sobre privacidade do Google AdSense.
  Utilizamos anúncios para compensar os custos de funcionamento deste site e fornecer financiamento para futuros desenvolvimentos. Os cookies de publicidade comportamental usados ​​por este site foram projetados para garantir que você forneça os anúncios mais relevantes sempre que possível, rastreando anonimamente seus interesses e apresentando coisas semelhantes que possam ser do seu interesse.
  Vários parceiros anunciam em nosso nome e os cookies de rastreamento de afiliados simplesmente nos permitem ver se nossos clientes acessaram o site através de um dos sites de nossos parceiros, para que possamos creditá-los adequadamente e, quando aplicável, permitir que nossos parceiros afiliados ofereçam qualquer promoção que pode fornecê-lo para fazer uma compra.

  Compromisso do Usuário
  O usuário se compromete a fazer uso adequado dos conteúdos e da informação que o Gerenciador de senha oferece no site e com caráter enunciativo, mas não limitativo:

  A) Não se envolver em atividades que sejam ilegais ou contrárias à boa fé a à ordem pública;
  B) Não difundir propaganda ou conteúdo de natureza racista, xenofóbica, 166bet ou azar, qualquer tipo de pornografia ilegal, de apologia ao terrorismo ou contra os direitos humanos;
  C) Não causar danos aos sistemas físicos (hardwares) e lógicos (softwares) do Gerenciador de senha, de seus fornecedores ou terceiros, para introduzir ou disseminar vírus informáticos ou quaisquer outros sistemas de hardware ou software que sejam capazes de causar danos anteriormente mencionados.
  
  Mais informações
  Esperemos que esteja esclarecido e, como mencionado anteriormente, se houver algo que você não tem certeza se precisa ou não, geralmente é mais seguro deixar os cookies ativados, caso interaja com um dos recursos que você usa em nosso site.

  Esta política é efetiva a partir de 19 de novembro 2023
""";
    }
    return """
  Privacy Policy

  Your privacy is important to us. It is Password Manager's policy to respect your privacy regarding any information we may collect from you on the Password Manager website, and other websites we own and operate.

  We only request personal information when we truly need it to provide you with a service. We do so by fair and legal means, with your knowledge and consent. We also tell you why we are collecting it and how it will be used.

  We only retain collected information for as long as necessary to provide the requested service. When we store data, we protect it within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use or modification.

  We do not share personally identifiable information publicly or with third parties except when required by law.

  Our website may have links to external websites that are not operated by us. Please be aware that we have no control over the content and practices of these sites and cannot accept responsibility for their respective privacy policies.

  You are free to refuse our request for your personal information, with the understanding that we may be unable to provide you with some of your desired services.

  Your continued use of our website will be considered acceptance of our practices around privacy and personal information. If you have any questions about how we handle user data and personal information, please contact us.


  The Google AdSense service we use to serve advertising uses a DoubleClick cookie to serve more relevant ads across the web and limit the number of times a particular ad is shown to you.
  For more information about Google AdSense, see the official Google AdSense Privacy FAQs.
  We use advertisements to offset the costs of running this site and provide funding for future development. The behavioral advertising cookies used by this site are designed to ensure that we provide you with the most relevant advertisements where possible by anonymously tracking your interests and presenting similar things that may be of interest to you.
  Several partners advertise on our behalf and affiliate tracking cookies simply allow us to see if our customers have accessed the site through one of our partners' sites so that we can credit them appropriately and, where applicable, allow our affiliate partners to offer any promotion that can provide you to make a purchase.

  User Commitment
  The user undertakes to make appropriate use of the content and information that the Password Manager offers on the website and with an enunciative but not limiting nature:

  A) Not engage in activities that are illegal or contrary to good faith and public order;
  B) Do not disseminate propaganda or content of a racist, xenophobic, gambling or gambling nature, any type of illegal pornography, in support of terrorism or against human rights;
  C) Do not cause damage to the physical (hardware) and logical (software) systems of the Password Manager, its suppliers or third parties, to introduce or disseminate computer viruses or any other hardware or software systems that are capable of causing the aforementioned damages.

  More information
  Hopefully that's clear, and as mentioned previously, if there's something you're not sure whether you need or not, it's usually safer to leave cookies enabled in case it interacts with one of the features you use on our site.

  This policy is effective from November 19, 2023
""";
  }
}
