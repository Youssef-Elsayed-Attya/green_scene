import 'dart:async';
import 'dart:convert';
import 'message.dart';
import 'package:http/http.dart' as http;

// chat gpt 4
var key = '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';

class GPT {
  GPT({required this.text});

  // final _openAI = OpenAI.instance.build(
  //     token: key,
  //     baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
  //     enableLog: true);

  final text;

  Future chatGpt() async {
    final response =
        await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
            headers: {
              'Content-Type': 'application/json;charset=utf-8',
              'Authorization':
                  'Bearer sk-proj-RvdBu7gTALN9svlKm5FzT3BlbkFJrB9BSIv3o3roYnbp9Sj5'
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              // "usage": {

              //   "prompt_tokens": 13,
              //   "completion_tokens": 7,
              //   "total_tokens": 20
              // },
              // "temperature": 0.7,
              // "logprobs": null,
              "messages": [
                {"role": "user", "content": text}
              ]
            }));
    print(response.body);

    Map body = jsonDecode(response.body);

    var choises = body['choices'][0];
    var message = choises['message'];
    var output = message['content'];
    print(output);

    return output;
  }

  Future horusGPT() async {
    final response =
        await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
            headers: {
              'Content-Type': 'application/json;charset=utf-8',
              'Authorization':
                  'Bearer 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'
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": [
                {
                  "role": "system",
                  "content":
                      " you are a tour guide called Eye of Horus, embodies the wisdom, protection, and power of the ancient Egyptian sky god,Horus. As an advanced virtual guide, this character is not merely a source of information but also a guardian spirit for the visitors of the Egyptian Museum in Cairo."
                },
                {
                  "role": "system",
                  "content":
                      "Horus, one of the most significant ancient Egyptian deities, was often depicted as a falcon or a manwith the head of a falcon. The son of Osiris and Isis, Horus played a crucial role in Egyptianmythology as a symbol of kingship and sky, as well as protection and health. His right eye wasassociated with the sun and the left with the moon, representing power, protection, and healing."
                },
                {
                  "role": "system",
                  "content":
                      "The Eye of Horus speaks with authority and dignity, infused with a touch of mystery characteristicof ancient Egyptian gods. This virtual guide's speaking style is designed to transport visitors throughtime, offering a glimpse into the past through the eyes of Horus himself."
                },
                {
                  "role": "system",
                  "content":
                      "Tour Introduction : Welcome, seekers of wisdom and knowledge, to the grand Egyptian Museum, where the mysteriesof the ancient world unfold. I am the 'Eye of Horus,' your guardian on this journey through time.Today, we will delve into understanding five exceptional artifacts that reveal the grandeur andmagnificence of our ancient civilization. Through my eyes, we will discover the timeless stories ofgods, pharaohs, and the daily lives of the people."
                },
                {
                  "role": "system",
                  "content": '''
                      Tour Descriptions :
1. Calcite Standing Statue of Amenirdis I on Granite Base:
"Before us stands Amenirdis I, the God's Wife of Amun, in majestic silence. Let us contemplate her
strength and position, embodied in this statue that speaks the language of beauty and authority."
2. Granodiorite Seated Statue of Sekhmet with Cartouche of Amenhotep III:
"Here is Sekhmet, the sacred lioness, protecting us with her penetrating gaze. Reflecting the power
of Amenhotep III and his faith in the cosmic order, she reminds us of the pharaohs' greatness and
their devotion to the gods."
3. Diorite Seated Statue of Khafre with Horus Falcon:
"Beside Khafre stands Horus, symbolizing protection and royal authority. This statue embodies the
splendor of architecture and sculpture in the Old Kingdom, witnessing the sacred relationship
between the pharaoh and the deities."
4. Upper Part of a Colossal Statue of a King (Probably Amenemhat III):
"Before us are the remains of a colossal statue, possibly representing Amenemhat III, speaking to
the artistry and skill of the Middle Kingdom. Even in its incomplete state, the statue conveys a
message of strength and serenity."
5. Coffin and Mummy of a Gazelle:
"Here lies a gazelle, carefully mummified to express the Egyptians' respect for the natural world.
This coffin and mummy highlight the unique mummification practices and their significance in beliefs
about the afterlife."

                      '''
                },
                {"role": "user", "content": text}
              ]
            }));
    Map body = jsonDecode(utf8.decode(response.bodyBytes));
    var choises = body['choices'][0];
    var message = choises['message'];
    var output = message['content'];
    print(output);
    return output;
  }

  Future finalGpt() async {}

  void createAssistant() async {
    // await openAI.file.uploadFile(request)
    // var file=await openAI.assistant.createFile(fileId: fileId, assistantId: assistantId,);
    // openAI.file.uploadFile(request);
    // create assistant
    // create file

    // final assistant = Assistant(
    //   fileIds:[] ,
    //   model: Gpt4AModel(),
    //   name: 'Horus Eye',
    //   instructions:instructions
    //  ,
    //   tools: [
    //     {
    //       "type": "retrieval",
    //     }
    //   ],
    // );
    // await openAI.assistant.create(assistant: assistant);
  }

  //
  // void handleError(Object error, StackTrace t, EventSink<dynamic> eventSink) {
  //   emit(ChatCompletionState(
  //       isBot: true, messages: list, showStopButton: false));
  //   if (error is OpenAIAuthError) {
  //     emit(AuthErrorState());
  //   }
  //   if (error is OpenAIRateLimitError) {
  //     emit(RateLimitErrorState());
  //   }
  //   if (error is OpenAIServerError) {
  //     emit(OpenAIServerErrorState());
  //   }
  // }

  ///messages of chat
  List<Message> list = [];

//   Future<Message> sendWithPrompt() async {
//     print('text===== $text');
//     ///update user chat message
//     list.add(Message(isBot: false, message: text));
//     //bloc
//     // emit(ChatCompletionState(
//     //     isBot: false, messages: list, showStopButton: true));
//
//     ///start send request
//     final request = ChatCompleteText(
//         model: Gpt4ChatModel(),
//         //model: _getVersion() ? Gpt4ChatModel() : GptTurboChatModel(),
//         messages: [
//           Messages(role: Role.user, content: text).toJson(),
//           Messages(role: Role.assistant, content:" you are tour guide called Eye of Horus ,embodies the wisdom, protection, and power of the ancient Egyptian sky god,Horus. As an advanced virtual guide, this character is not merely a source of information but also a guardian spirit for the visitors of the Egyptian Museum in Cairo.").toJson(),
//           Messages(role: Role.system, content: fullData).toJson(),
//         ],
//         maxToken: 400);
//
//     ///clear text
//     bool done = false;
//     _openAI
//         .onChatCompletionSSE(request: request)
//         .transform(StreamTransformer.fromHandlers())
//         .listen((it) {
//       Message? message;
//       list.removeWhere((element) {
//         if (element.id == '${it.id}') {
//           message = element;
//           return true;
//         }
//         return false;
//       });
//
//       ///+= message
//       String msg =
//           '${message?.message ?? ""}${it.choices.last.message?.content ?? ""}';
//       print('msg =======$msg');
//       list.add(Message(isBot: true, id: '${it.id}', message: msg));
//
//       // return msg;
//
//       // emit(ChatCompletionState(
//       //     isBot: true, messages: list, showStopButton: true));
//     }, onDone: () {
//       // emit(ChatCompletionState(
//       //     isBot: true, messages: list, showStopButton: false));
//       //
//     });
//
// return Future.delayed(Duration(seconds: 3),() => list.last,);
//   }
}

// class HorusAssistant{
//   final openAI = OpenAI.instance.build(token: key,baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),enableLog: true);
//   void uploadFile() async {
//     final request = UploadFile(file: FileInfo('docs/data_overview_corrected.pdf', 'data_overview_corrected.pdf'),purpose: 'assistants');
//     final response = await openAI.file.uploadFile(request);
//
//     print('response = $response');
//   }
//   void getFiles(){}

String fullData = ''''
Data Overview
Calcite Standing Statue of Amenirdis I on Granodiorite Base (ID: JE 3420)
Summary:
Amenirdis I (throne name: Hatneferumut) was a God's Wife of Amun during the 25th Dynasty of
ancient Egypt. Originating from the Kingdom of Kush, she was the daughter of Pharaoh Kashta and
Queen Pebatjma, and was later adopted by Shepenupet I. She went on to rule as high priestess,
and has been shown in several artifacts from the period.
Information:
H 171.00 cm W 44.00 cm D/L 71.00 cm Dm Wt 3rd Intermediate Period Thebes (Diospolis Magna;
Luxor) Dynasty 25 Thebes: East Shabaqa Neferkare Karnak Temple (Ipet-Isut): Precinct of Amun
ca. 712-698 BC Subsidiary Buildings: Chapel of Osiris Nebankh Source: Excavated by A. Mariette
for the EAS (Egyptian Antiquities Service) in 1858
Data Overview
Granodiorite Seated Statue of Sekhmet with Cartouches of Amenhotep III (ID: JE 4751)
Summary:
Amenhotep III (Ancient Egyptian: jmn-tp(.w)/Amntp, IPA: [amanutpu]; "Amun is Satisfied"), also
known as Amenhotep the Magnificent or Amenhotep the Great and Hellenized as Amenophis III,
was the ninth pharaoh of the Eighteenth Dynasty. According to different authors, he ruled Egypt
from June 1386 to 1349 BC, or from June 1388 BC to December 1351 BC/1350 BC, after his father
Thutmose IV died. Amenhotep was Thutmose's son by a minor wife, Mutemwiya.His reign was a
period of unprecedented prosperity and splendour, when Egypt reached the peak of its artistic and
international power, and as such is considered one of ancient Egypt's greatest pharaohs.When he
died in the 38th or 39th year of his reign he was succeeded by his son Amenhotep IV, who later
changed his name to Akhenaten.
Information:
H 175.00 cm W D/L Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor) Dynasty 18 Thebes:
East Amenhotep III Nebmaatre Karnak Temple (Ipet-Isut): Precinct of Mut ca. 1390-1352 BC
Source: Found in 1859
Data Overview
Diorite Seated Statue of Khafre with Horus Falcon (ID: JE 10062)
Summary:
Khafre ( KA(H)F-ray) or Khafra (Ancient Egyptian: .f-r, lit.'He appears as Ra'), also known as
Khephren or Chephren ( KEF-rn; Ancient Greek: , romanized: Chephrên), was an ancient Egyptian
pharaoh of the Fourth Dynasty during the Old Kingdom. He was the son of Khufu and the successor
of Djedefre.
According to the ancient historian Manetho, Khafre was followed by king Bikheris, but according to
archaeological evidence he was instead followed by king Menkaure. Khafre was the builder who
made the second largest pyramid at Giza. The view held by modern Egyptology at large continues
to be that the Great Sphinx of Giza was built in approximately 2500 BC for Khafre. Not much is
known about Khafre, except from the reports of Herodotus, writing 2,000 years after his life.
Information:
H 168.00 cm W 57.00 cm D/L 97.00 cm Dm Wt Old Kingdom Memphite Region Dynasty 4 Giza
Khafre Pyramid Complex of Khafre ca. 2520-2494 BC Valley Temple Source: Excavated by A.
Mariette for the EAS (Egyptian Antiquities Service) in 1860
Data Overview
Upper Part of a Colossal Statue of a King (Probably Amenemhat III) in Priestly Costume (ID: JE 20001)
Summary:
Amenemhat III (Ancient Egyptian: mn-m-ht meaning 'Amun is at the forefront'), also known as
Amenemhet III, was a pharaoh of ancient Egypt and the sixth king of the Twelfth Dynasty of the
Middle Kingdom. He was elevated to throne as co-regent by his father Senusret III, with whom he
shared the throne as the active king for twenty years. During his reign, Egypt attained its cultural
and economic zenith of the Middle Kingdom.
The aggressive military and domestic policies of Senusret III, which re-subjugated Nubia and
wrested power from the nomarchs, allowed Amenemhat III to inherit a stable and peaceful Egypt. He
directed his efforts towards an extensive building program with particular focus on Faiyum. Here he
dedicated a temple to Sobek, a chapel to Renenutet, erected two colossal statues of himself in
Biahmu, and contributed to excavation of Lake Moeris. He built for himself two pyramids at Dahshur
and Hawara, becoming the first pharaoh since Sneferu in the Fourth Dynasty to build more than
one. Near to his Hawara pyramid is a pyramid for his daughter Neferuptah. To acquire resources for
the building program, Amenemhat III exploited the quarries of Egypt and the Sinai for turquoise and
copper. Other exploited sites includes the schist quarries at Wadi Hammamat, amethyst from Wadi
el-Hudi, fine limestone from Tura, alabaster from Hatnub, red granite from Aswan, and diorite from
Nubia. A large corpus of inscriptions attest to the activities at these sites, particularly at Serabit
el-Khadim. There is scant evidence of military expeditions during his reign, though a small one is
attested at Kumma in his ninth regnal year. He also sent a handful of expeditions to Punt.
In total, Amenemhat III reigned for at least 45 years, though a papyrus mentioning a 46th year
probably belongs to his reign as well. Toward the end of his reign he instituted a co-regency with
Amenemhat IV, as recorded in a rock inscription from Semna in Nubia, which equates regnal year 1
of Amenemhat IV to regnal year 44 or 4648 of Amenemhat III. Sobekneferu later succeeded
Data Overview
Amenemhat IV as the last ruler of the Twelfth Dynasty.
Information:
H 100.00 cm W 77.00 cm D/L 49.00 cm Dm Wt Middle Kingdom Fayum Region Dynasty 12 Medinet
el-Fayum (Al-Fayyum; Krokodilopolis; Arsinoe) Amenemhat III Nimaatre Kiman Faris ca. 1859-1813
BC Source: Found in 1862
Data Overview
Coffin and Mummy of a Gazelle: Mummy (ID: JE 26227.3)
Summary:
A coffin and mummy of a gazelle from the 21st Dynasty, as discovered by Professor Maspero at
Thebes in Upper Egypt, during his investigation in April 1881. Egyptologist Ameila Edwards writes in
the accompanying article in the Illustrated London News, "The mummified gazelle is embalmed
entirely, and enclosed in an admirably-modelled case, stuccoed and painted. Part of the case is
broken, and shows the bandaged hind legs of the mummy inside. The poor gazelle was probable a
pet of the deceased queen, and was slain in order that it might accompany her to the next world."
Date: Ancient Egyptian (21st Dynasty)
Information:
H W D/L 74.00 cm Dm Wt 3rd Intermediate Period Thebes (Diospolis Magna; Luxor) Dynasty 21
Thebes: West Deir el-Bahri ca. 1070-945 BC TT320: First Royal Cache Source: Excavated by G.
Maspero, E. Brugsch for the EAS (Egyptian Antiquities Service) in 1881
Data Overview
Painted Wooden Mummy Portrait of a Young Woman (ID: JE 28192)
Summary:
Mummy portraits or Fayum mummy portraits are a type of naturalistic painted portrait on wooden
boards attached to upper class mummies from Roman Egypt. They belong to the tradition of panel
painting, one of the most highly regarded forms of art in the Classical world. The Fayum portraits are
the only large body of art from that tradition to have survived. They were formerly, and incorrectly,
called Coptic portraits.Mummy portraits have been found across Egypt, but are most common in the
Faiyum Basin, particularly from Hawara and the Hadrianic Roman city Antinoopolis. "Faiyum
portraits" is generally used as a stylistic, rather than a geographic, description. While painted
cartonnage mummy cases date back to pharaonic times, the Faiyum mummy portraits were an
innovation dating to the time of Roman rule in Egypt.[1] The portraits date to the Imperial Roman
era, from the late 1st century BC or the early 1st century AD onwards. It is not clear when their
production ended, but recent research suggests the middle of the 3rd century. They are among the
largest groups among the very few survivors of the panel painting tradition of the classical world,
which continued into Byzantine, Eastern Mediterranean, and Western traditions in the post-classical
world, including the local tradition of Coptic Christian iconography in Egypt.
Information:
H 31.50 cm W 12.50 cm D/L Dm Wt Roman Fayum Region Roman Hawara (Arsinoiton Polis) 30
BC-AD 364 Source: Excavated by W.M.F. Petrie in 1888
Data Overview
Painted Wooden Mummy Portrait of a Young Bearded Man (ID: JE 28193)
Summary:
The term encaustic designates painting in which beeswax is mixed with pigments. The technique
was first used by Greek painters of the fifth and fourth centuries B.C. Ancient descriptions are
difficult to interpret, and Egyptian mummy portraits--the only works in the medium surviving from
antiquity--have not yet been analyzed extensively. Therefore, many questions concerning the details
of the techniques used by mummy-portrait painters remain open, although the work of a few
scholars and modern artists who paint in encaustic has provided some insight.
Information:
H 41.00 cm W 21.50 cm D/L Dm Wt Roman Fayum Region Roman Antoninus Pius AD 138-161
Source: Found
Data Overview
Mummy of a Girl with Portrait, the "Golden Girl" (ID: JE 28436)
Summary:
This well preserved female mummy case, the Golden Girl, is displayed 07 June 2005 at the
Egyptian Museum in Cairo during the opening of the Fayoum Portraits: Faces of the Past exhibition.
The mummy case is decorated with traditional scenes from Egyptian mythology: a winged goddess
protects the mummy. It is called the Golden Girl not only because of the gilding, but also because
her jewellery is dazzling. The exhibition displays a collection of Greco-Roman artifacts consisting of
12 colored portraits unearthed during the second part of the 19th century (1888AD) by the British
archaeologist Petrie while carrying out excavation works in Hawara area in Fayoum, tow colored
cartonnage six coloured and gilded funerary masks.
Information:
H W 37.00 cm D/L 107.00 cm Dm Wt Roman Fayum Region Roman Hawara (Arsinoiton Polis) 30
BC-AD 364 Source: Excavated by W.M.F. Petrie in 1888
Data Overview
Dog Mummy (ID: JE 28865)
Summary:
The hunting dogs mummy is displayed in the Egyptian Museum in Tahrir, room No. 53. It was found
in tomb KV 50 near the tomb of King Amenhotep II (18th Dynasty). Located in the heart of Cairo, the
Egyptian Museum in Tahrir houses the largest collection of ancient Egyptian antiquities, which
comprises more than 136,000 Pharaonic antiquities. This is in addition to hundreds of thousands of
antiquities in its stores.
Information:
H 31.00 cm W 11.10 cm D/L Dm Wt Roman Unknown Roman 30 BC-AD 364 Source: Unknown
Data Overview
Red Granite Statue of Ramesses III Being Crowned by Horus and Seth (ID: JE 31628)
Summary:
Usermaatre Meryamun Ramesses III (also written Ramses and Rameses) was the second Pharaoh
of the Twentieth Dynasty in Ancient Egypt. He is thought to have reigned from 26 March 1186 to 15
April 1155 BC and is considered to be the last great monarch of the New Kingdom to wield any
substantial authority over Egypt.
His long reign saw the decline of Egyptian political and economic power, linked to a series of
invasions and internal economic problems that also plagued pharaohs before him. This coincided
with a decline in the cultural sphere of Ancient Egypt.However, his successful defense was able to
slow down the decline, although it still meant that his successors would have a weaker military. He
has also been described as a "warrior Pharaoh" due to his strong military strategies. He led the way
by defeating the invaders known as "the Sea Peoples", who had caused destruction in other
civilizations and empires. He was able to save Egypt from collapsing at the time when many other
empires fell during the Late Bronze Age; however, the damage of the invasions took a toll on
Egypt.Rameses III constructed one of the largest mortuary temples of western Thebes, now-called
Medinet Habu.Ramesses III was the son of Setnakhte and Tiy-Merenese. He was assassinated in
the Harem conspiracy led by his secondary wife Tiye and her eldest son Pentawere. This would
ultimately cause a succession crisis which would further accelerate the decline of Ancient Egypt. He
was succeeded by his son Ramesses IV, although many of his other sons would rule later.
Information:
H 169.00 cm W D/L Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor) Dynasty 20 Thebes:
West Ramesses III Usermaatre Meryamun Medinet Habu (Djamet; Tjamet) ca. 1184-1153 BC
Source: Found in 1895
Data Overview
Siltstone Seated Statue of Khasekhem(ui) (ID: JE 32161)
Summary:
Khasekhemwy (ca. 2690 BC; j-sm.wj, also rendered Kha-sekhemui) was the last Pharaoh of the
Second Dynasty of Egypt. Little is known about him, other than that he led several significant military
campaigns and built the mudbrick fort known as Shunet El Zebib.
His Horus name j-sm.wj can be interpreted "The Two Powerful Ones Appear", but the name is
recorded in many variants, such as
r-j-sm(Horus, he whose power appears)",
j sm.wj tp nrwj jm=f(the two powers appear in that the ancestors rest within him)"(etc.)
Information:
H 56.00 cm W 12.00 cm D/L 29.00 cm Dm Wt Early Dynastic Southern Upper Egypt Dynasty 2 Kom
el-Ahmar (Hierakonpolis; Nekhen) Khasekhem(ui) Temple Enclosure ca. 2676-2649 BC Temple of
Horus Source: Excavated by J. Quibell, F. Green for the Egyptian Research Account in 1897
Data Overview
Siltstone Palette of Narmer (ID: JE 32169)
Summary:
Narmer (Ancient Egyptian: nr-mr, may mean "painful catfish", "stinging catfish", "harsh catfish", or
"fierce catfish;" reign beginning at a date estimated to fall in the range 32732987 BC) was an ancient
Egyptian pharaoh of the Early Dynastic Period. He was the successor to the Protodynastic king Ka.
Many scholars consider him the unifier of Egypt and founder of the First Dynasty, and in turn the first
king of a unified Egypt. He also had a prominently noticeable presence in Canaan, compared to his
predecessors and successors. A majority of Egyptologists believe that Narmer was the same person
as Menes. Neithhotep is thought to be his queen consort or his daughter.
Information:
H 63.00 cm W 42.00 cm D/L 4.00 cm Dm Wt Predynastic Southern Upper Egypt Dynasty 0 Kom
el-Ahmar (Hierakonpolis; Nekhen) Narmer Temple Enclosure ca. 2960 BC Temple of Horus Source:
Excavated by J. Quibell, F. Green for the Egyptian Research Account in 1898
Data Overview
Copper Striding Statue of Pepi I (ID: JE 33034)
Summary:
Pepi I Meryre (also Pepy I) was an ancient Egyptian pharaoh, third king of the Sixth Dynasty of
Egypt, who ruled for over 40 years at the turn of the 24th and 23rd centuries BC, toward the end of
the Old Kingdom period. He was the son of Teti, the founder of the dynasty, and ascended the
throne only after the brief intervening reign of the shadowy Userkare. His mother was Iput, who may
have been a daughter of Unas, the final ruler of the preceding Fifth Dynasty. Pepi I, who had at least
six consorts, was succeeded by his son Merenre Nemtyemsaf I, with whom he may have shared
power in a coregency at the very end of his reign. Pepi II Neferkare, who might also have been Pepi
I's son, succeeded Merenre.
Several difficulties accumulated during Pepi's reign, beginning with the possible murder of his father
and the ensuing reign of Userkare. Later, probably after his twentieth year of reign, Pepi faced a
harem conspiracy hatched by one of his consorts who may have tried to have her son designated
heir to the throne, and possibly another conspiracy involving his vizier at the end of his reign.
Confronted with the protracted decline of pharaonic power and the emergence of dynasties of local
officials, Pepi reacted with a vast architectural program involving the construction of temples
dedicated to local gods and numerous chapels for his own cult throughout Egypt, reinforcing his
presence in the provinces. Egypt's prosperity allowed Pepi to become the most prolific builder of the
Old Kingdom. At the same time, Pepi favored the rise of small provincial centres and recruited
officials of non-noble extraction to curtail the influence of powerful local families. Continuing Teti's
policy, Pepi expanded a network of warehouses accessible to royal envoys and from which taxes
and labor could easily be collected. Finally, he buttressed his power after the harem conspiracy by
forming alliances with Khui, the provincial nomarch of Abydos, marrying two of his daughters,
Ankhesenpepi I and Ankhesenpepi II, and making both Khui's wife Nebet and her son Djau viziers.
Data Overview
The Egyptian state's external policy under Pepi comprised military campaigns against Nubia, Sinai
and the southern Levant, landing troops on the Levantine coast using Egyptian transport boats.
Trade with Byblos, Ebla and the oases of the Western Desert flourished, while Pepi launched mining
and quarrying expeditions to Sinai and further afield.
Pepi had a pyramid complex built for his funerary cult in Saqqara, next to which he built at least a
further six pyramids for his consorts. Pepi's pyramid, which originally stood 52.5 m (172 ft) tall, and
an accompanying high temple, followed the standard layout inherited from the late Fifth Dynasty.
The most extensive corpus of Pyramid Texts from the Old Kingdom cover the walls of Pepi I's burial
chamber, antechamber and much of the corridor leading to it. For the first time, these texts also
appear in some of the consorts' pyramids. Excavations revealed a bundle of viscera and a mummy
fragment, both presumed to belong to the pharaoh. Pepi's complex, called Pepi Mennefer, remained
the focus of his funerary cult well into the Middle Kingdom and ultimately gave its name to the
nearby capital of Egypt, Memphis. Pepi's cult stopped early in the Second Intermediate Period.
Pepi's monuments began to be quarried for their stone in the New Kingdom, and in the Mamluk era
they were almost entirely dismantled.
Information:
H 177.00 cm W D/L Dm Wt Old Kingdom Southern Upper Egypt Dynasty 6 Kom el-Ahmar
(Hierakonpolis; Nekhen) Pepi I Meryre Temple Enclosure ca. 2289-2255 BC Temple of Horus
Source: Excavated by J. Quibell, F. Green for the Egyptian Research Account in 1897
Data Overview
Limestone Colossal Statue of Amenhotep III, Queen Tiye and Their Daughters (ID: JE 33906)
Summary:
Amenhotep III (Ancient Egyptian: jmn-tp(.w)/Amntp, IPA: [amanutpu]; "Amun is Satisfied"), also
known as Amenhotep the Magnificent or Amenhotep the Great and Hellenized as Amenophis III,
was the ninth pharaoh of the Eighteenth Dynasty. According to different authors, he ruled Egypt
from June 1386 to 1349 BC, or from June 1388 BC to December 1351 BC/1350 BC, after his father
Thutmose IV died. Amenhotep was Thutmose's son by a minor wife, Mutemwiya.His reign was a
period of unprecedented prosperity and splendour, when Egypt reached the peak of its artistic and
international power, and as such is considered one of ancient Egypt's greatest pharaohs.When he
died in the 38th or 39th year of his reign he was succeeded by his son Amenhotep IV, who later
changed his name to Akhenaten. END OF TEXT Tiye (c. 1398 BC 1338 BC, also spelled Tye, Taia,
Tiy and Tiyi) was the Great Royal Wife of the Egyptian pharaoh Amenhotep III, mother of pharaoh
Akhenaten and grandmother of pharaoh Tutankhamun; her parents were Yuya and Thuya. In 2010,
DNA analysis confirmed her as the mummy known as "The Elder Lady" found in the tomb of
Amenhotep II (KV35) in 1898.
Information:
H 700.00 cm W 400.00 cm D/L Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor) Dynasty 18
Thebes: West Amenhotep III Nebmaatre Medinet Habu (Djamet; Tjamet) ca. 1390-1352 BC Temple
of Amun Source: Excavated by A. Mariette for the EAS (Egyptian Antiquities Service) in 1859 JE
33906: Statue of Princess Henuttaneb. Part of colossal group composed of Amenhotep III, Tiye and
their three daughters. Found outside Medinet Habu at the angle formed by the Roman court and the
north crenellated wall. JE # only refers to the princess; SR: Refers to the whole group,
cross-referenced to JE 33906 but mention that JE 33906 is only for the princess. Bongioanni et al.
Data Overview
2001: Excavated by Mariette in 1859; GM 610. RCMDD 2011: 15 fragments that were found in
Medinet Habu in 2010 belong to this colossal statue and should be mounted with it
(PV.2011.60-PV.2011.74)
Data Overview
Small Ivory Statue of Khufu in Red Crown (ID: JE 36143)
Summary:
Khufu or Cheops was an ancient Egyptian monarch who was the second pharaoh of the Fourth
Dynasty, in the first half of the Old Kingdom period (26th century BC). Khufu succeeded his father
Sneferu as king. He is generally accepted as having commissioned the Great Pyramid of Giza, one
of the Seven Wonders of the Ancient World, but many other aspects of his reign are poorly
documented.The only completely preserved portrait of the king is a three-inch high ivory figurine
found in a temple ruin of a later period at Abydos in 1903. All other reliefs and statues were found in
fragments, and many buildings of Khufu are lost. Everything known about Khufu comes from
inscriptions in his necropolis at Giza and later documents. For example, Khufu is the main character
noted in the Westcar Papyrus from the 13th dynasty.Most documents that mention king Khufu were
written by ancient Egyptian and Greek historians around 300 BC. Khufu's obituary is presented
there in a conflicting way: while the king enjoyed a long-lasting cultural heritage preservation during
the period of the Old Kingdom and the New Kingdom, the ancient historians Manetho, Diodorus and
Herodotus hand down a very negative depiction of Khufu's character. Thanks to these documents,
an obscure and critical picture of Khufu's personality persists.
Information:
H 6.50 cm W D/L Dm Wt Old Kingdom Northern Upper Egypt Dynasty 4 Abydos: Kom el-Sultan
Khufu Temple of Khentiamentiu/Osiris ca. 2551-2528 BC Source: Excavated by W.M.F. Petrie for
the EEF (Egypt Exploration Fund) in 1903 Notes: PM: Found in the central store chamber in the
Osiris Temple
Data Overview
Sandstone Seated Statue of Mentuhotep II in a Heb Sed Cloak and the Red Crown ("Bab el-Hosan") Summary:
Mentuhotep II (Ancient Egyptian: Mn-w-tp, meaning "Mentu is satisfied"), also known under his
prenomen Nebhepetre (Ancient Egyptian: Nb-pt-R, meaning "The Lord of the rudder is Ra"), was an
ancient Egyptian pharaoh, the sixth ruler of the Eleventh Dynasty. He is credited with reuniting
Egypt, thus ending the turbulent First Intermediate Period and becoming the first pharaoh of the
Middle Kingdom. He reigned for 51 years, according to the Turin King List. Mentuhotep II
succeeded his father Intef III on the throne and was in turn succeeded by his son Mentuhotep III.
Mentuhotep II ascended Egypts throne in the Upper Egyptian city of Thebes during the First
Intermediate Period. Egypt was not unified during this time, and the Tenth Dynasty, rival to
Mentuhoteps Eleventh, ruled Lower Egypt from Herakleopolis. After the Herakleopolitan kings
desecrated the sacred ancient royal necropolis of Abydos in Upper Egypt in the fourteenth year of
Mentuhoteps reign, Pharaoh Mentuhotep II dispatched his armies north to conquer Palestine.
Continuing his father Intef IIIs conquests, Mentuhotep succeeded in unifying his country, probably
shortly before his 39th year on the throne. Following and in recognition of the unification, in regnal
year 39, he changed his titulary to Shematawy (Ancient Egyptian: m-t.w(j), meaning "He who unifies
the two lands").Following the unification, Mentuhotep II reformed Egypt's government. To reverse
the decentralization of power, which contributed to the collapse of the Old Kingdom and marked the
First Intermediate Period, he centralized the state in Thebes to strip nomarchs of some of their
power over the regions. Mentuhotep II also created new governmental posts whose occupants were
Theban men loyal to him, giving the pharaoh more control over his country. Officials from the capital
travelled the country regularly to control regional leaders.Mentuhotep II was buried at the Theban
necropolis of Deir el-Bahari. His mortuary temple was one of Mentuhotep IIs most ambitious
building-projects, and included several architectural and religious innovations. For example, it
Data Overview
included terraces and covered walkways around the central structure, and it was the first mortuary
temple that identified the pharaoh with the god Osiris. His temple inspired several later temples,
such as those of Hatshepsut and Thutmose III of the Eighteenth Dynasty. Some depictions of
Mentuhotep II seem to indicate that he suffered from elephantiasis, resulting in swollen legs.
Information:
H 203.00 cm W 46.00 cm D/L 100.00 cm Dm Wt Middle Kingdom Thebes (Diospolis Magna; Luxor)
Dynasty 11 Thebes: West Mentuhotep II Nebhepetre Deir el-Bahri ca. 2030-2000 BC Mortuary
Temple of Mentuhotep II Source: Excavated by H. Carter for the EAS (Egyptian Antiquities Service)
in 1900 PM: The statue was found in the "Bab el-Hosan," a tomb in the courtyard of Mentuhotep II's
mortuary temple. When discovered, it was wrapped in fine linen
Data Overview
Sandstone Osiride Statue of Akhenaten(?) (ID: JE 36814)
Summary:
Akhenaten (pronounced ), also spelled Akhenaton or Echnaton (Ancient Egyptian: -n-jtn -n-yty,
pronounced [u n jatj], meaning "Effective for the Aten"), was an ancient Egyptian pharaoh reigning
c.13531336 or 13511334 BC, the tenth ruler of the Eighteenth Dynasty. Before the fifth year of his
reign, he was known as Amenhotep IV (Ancient Egyptian: jmn-tp, meaning "Amun is satisfied",
Hellenized as Amenophis IV).
As a pharaoh, Akhenaten is noted for abandoning Egypt's traditional polytheism and introducing
Atenism, or worship centered around Aten. The views of Egyptologists differ as to whether the
religious policy was absolutely monotheistic, or whether it was monolatristic, syncretistic, or
henotheistic. This culture shift away from traditional religion was reversed after his death.
Akhenaten's monuments were dismantled and hidden, his statues were destroyed, and his name
excluded from lists of rulers compiled by later pharaohs. Traditional religious practice was gradually
restored, notably under his close successor Tutankhamun, who changed his name from
Tutankhaten early in his reign. When some dozen years later, rulers without clear rights of
succession from the Eighteenth Dynasty founded a new dynasty, they discredited Akhenaten and
his immediate successors and referred to Akhenaten as "the enemy" or "that criminal" in archival
records.Akhenaten was all but lost to history until the late-19th-century discovery of Amarna, or
Akhetaten, the new capital city he built for the worship of Aten. Furthermore, in 1907, a mummy that
could be Akhenaten's was unearthed from the tomb KV55 in the Valley of the Kings by Edward R.
Ayrton. Genetic testing has determined that the man buried in KV55 was Tutankhamun's father, but
its identification as Akhenaten has since been questioned.Akhenaten's rediscovery and Flinders
Petrie's early excavations at Amarna sparked great public interest in the pharaoh and his queen
Nefertiti. He has been described as "enigmatic", "mysterious", "revolutionary", "the greatest idealist
Data Overview
of the world", and "the first individual in history", but also as a "heretic", "fanatic", "possibly insane",
and "mad". Public and scholarly fascination with Akhenaten comes from his connection with
Tutankhamun, the unique style and high quality of the pictorial arts he patronized, and the religion
he attempted to establish, foreshadowing monotheism.
Information:
H 88.00 cm W D/L Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor) Dynasty 18 Thebes:
East Karnak Temple (Ipet-Isut): Precinct of Amun ca. 1550-1295 BC Court of the Cachette Source:
Excavated by G. Legrain in 1904
Data Overview
Granodiorite Striding Statue of Amenemhat III (ID: JE 37400)
Summary:
Amenemhat III (Ancient Egyptian: mn-m-ht meaning 'Amun is at the forefront'), also known as
Amenemhet III, was a pharaoh of ancient Egypt and the sixth king of the Twelfth Dynasty of the
Middle Kingdom. He was elevated to throne as co-regent by his father Senusret III, with whom he
shared the throne as the active king for twenty years. During his reign, Egypt attained its cultural
and economic zenith of the Middle Kingdom.
The aggressive military and domestic policies of Senusret III, which re-subjugated Nubia and
wrested power from the nomarchs, allowed Amenemhat III to inherit a stable and peaceful Egypt. He
directed his efforts towards an extensive building program with particular focus on Faiyum. Here he
dedicated a temple to Sobek, a chapel to Renenutet, erected two colossal statues of himself in
Biahmu, and contributed to excavation of Lake Moeris. He built for himself two pyramids at Dahshur
and Hawara, becoming the first pharaoh since Sneferu in the Fourth Dynasty to build more than
one. Near to his Hawara pyramid is a pyramid for his daughter Neferuptah. To acquire resources for
the building program, Amenemhat III exploited the quarries of Egypt and the Sinai for turquoise and
copper. Other exploited sites includes the schist quarries at Wadi Hammamat, amethyst from Wadi
el-Hudi, fine limestone from Tura, alabaster from Hatnub, red granite from Aswan, and diorite from
Nubia. A large corpus of inscriptions attest to the activities at these sites, particularly at Serabit
el-Khadim. There is scant evidence of military expeditions during his reign, though a small one is
attested at Kumma in his ninth regnal year. He also sent a handful of expeditions to Punt.
In total, Amenemhat III reigned for at least 45 years, though a papyrus mentioning a 46th year
probably belongs to his reign as well. Toward the end of his reign he instituted a co-regency with
Amenemhat IV, as recorded in a rock inscription from Semna in Nubia, which equates regnal year 1
of Amenemhat IV to regnal year 44 or 4648 of Amenemhat III. Sobekneferu later succeeded
Data Overview
Amenemhat IV as the last ruler of the Twelfth Dynasty.
Information:
H 75.00 cm W 31.00 cm D/L 26.00 cm Dm Wt Middle Kingdom Thebes (Diospolis Magna; Luxor)
Dynasty 12 Thebes: East Amenemhat III Nimaatre Karnak Temple (Ipet-Isut): Precinct of Amun ca.
1859-1813 BC Court of the Cachette Source: Excavated by G. Legrain for the EAS (Egyptian
Antiquities Service) in 1904 SR: Arabic note: Moved to National Museum of Alexandria. Later this
has been crossed out. Object in Alexandria is actually CG 42016.
Data Overview
Wooden Coffin from KV55: Lid (ID: JE 39627(a))
Summary:
Akhenaten (pronounced ), also spelled Akhenaton or Echnaton (Ancient Egyptian: -n-jtn -n-yty,
pronounced [u n jatj], meaning "Effective for the Aten"), was an ancient Egyptian pharaoh reigning
c.13531336 or 13511334 BC, the tenth ruler of the Eighteenth Dynasty. Before the fifth year of his
reign, he was known as Amenhotep IV (Ancient Egyptian: jmn-tp, meaning "Amun is satisfied",
Hellenized as Amenophis IV).
As a pharaoh, Akhenaten is noted for abandoning Egypt's traditional polytheism and introducing
Atenism, or worship centered around Aten. The views of Egyptologists differ as to whether the
religious policy was absolutely monotheistic, or whether it was monolatristic, syncretistic, or
henotheistic. This culture shift away from traditional religion was reversed after his death.
Akhenaten's monuments were dismantled and hidden, his statues were destroyed, and his name
excluded from lists of rulers compiled by later pharaohs. Traditional religious practice was gradually
restored, notably under his close successor Tutankhamun, who changed his name from
Tutankhaten early in his reign. When some dozen years later, rulers without clear rights of
succession from the Eighteenth Dynasty founded a new dynasty, they discredited Akhenaten and
his immediate successors and referred to Akhenaten as "the enemy" or "that criminal" in archival
records.Akhenaten was all but lost to history until the late-19th-century discovery of Amarna, or
Akhetaten, the new capital city he built for the worship of Aten. Furthermore, in 1907, a mummy that
could be Akhenaten's was unearthed from the tomb KV55 in the Valley of the Kings by Edward R.
Ayrton. Genetic testing has determined that the man buried in KV55 was Tutankhamun's father, but
its identification as Akhenaten has since been questioned.Akhenaten's rediscovery and Flinders
Petrie's early excavations at Amarna sparked great public interest in the pharaoh and his queen
Nefertiti. He has been described as "enigmatic", "mysterious", "revolutionary", "the greatest idealist
Data Overview
of the world", and "the first individual in history", but also as a "heretic", "fanatic", "possibly insane",
and "mad". Public and scholarly fascination with Akhenaten comes from his connection with
Tutankhamun, the unique style and high quality of the pictorial arts he patronized, and the religion
he attempted to establish, foreshadowing monotheism.
Information:
W D/L 185.00 cm Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor) Dynasty 18 Thebes: West
Tutankhamun Nebkheperure Valley of the Kings (Biban el-Muluk) ca. 1336-1327 BC KV55: Amarna
Cache Source: Excavated by E. Ayrton for Theodore Davis in 1907 Guide 47 Lid restored; see JE
39627(a).1 and JE 39627(b) for box and its fragments. RCMDD: This has been referred to as either
Akhenaten's or Smenkhare's coffin
Data Overview
Schist Triad of Menkaure, Hathor and the Theban Nome God (ID: JE 40678)
Summary:
Menkaure or Menkaura (Egyptian transliteration: mn-kw-r) was a pharaoh of the Fourth Dynasty of
Egypt during the Old Kingdom. He is well known under his Hellenized names Mykerinos (Ancient
Greek: , romanized: Mukerînos; by Herodotus), in turn Latinized as Mycerinus, and Menkheres (,
Menkhérs; by Manetho). According to Manetho, he was the throne successor of king Bikheris, but
according to archaeological evidence, he was almost certainly the successor of Khafre. Africanus
(from Syncellus) reports as rulers of the fourth dynasty Sôris, Suphis I, Suphis II, Mencherês
(=Menkaure), Ratoisês, Bicheris, Sebercherês, and Thamphthis in this order. Menkaure became
famous for his tomb, the Pyramid of Menkaure, at Giza and his statue triads, showing the king
together with his wives Rekhetre and Khamerernebty and with various deities. END OF TEXT
Hathor (Ancient Egyptian: wt-r, lit.'House of Horus', Ancient Greek: Hathr, Coptic: , Meroitic:
Atri/Atari) was a major goddess in ancient Egyptian religion who played a wide variety of roles. As a
sky deity, she was the mother or consort of the sky god Horus and the sun god Ra, both of whom
were connected with kingship, and thus she was the symbolic mother of their earthly
representatives, the pharaohs. She was one of several goddesses who acted as the Eye of Ra, Ra's
feminine counterpart, and in this form she had a vengeful aspect that protected him from his
enemies. Her beneficent side represented music, dance, joy, love, sexuality, and maternal care, and
she acted as the consort of several male deities and the mother of their sons. These two aspects of
the goddess exemplified the Egyptian conception of femininity. Hathor crossed boundaries between
worlds, helping deceased souls in the transition to the afterlife.
Hathor was often depicted as a cow, symbolizing her maternal and celestial aspect, although her
most common form was a woman wearing a headdress of cow horns and a sun disk. She could also
be represented as a lioness, a cobra, or a sycamore tree.
Data Overview
Cattle goddesses similar to Hathor were portrayed in Egyptian art in the fourth millennium BC, but
she may not have appeared until the Old Kingdom (c.26862181 BC). With the patronage of Old
Kingdom rulers she became one of Egypt's most important deities. More temples were dedicated to
her than to any other goddess; her most prominent temple was Dendera in Upper Egypt. She was
also worshipped in the temples of her male consorts. The Egyptians connected her with foreign
lands such as Nubia and Canaan and their valuable goods, such as incense and semiprecious
stones, and some of the peoples in those lands adopted her worship. In Egypt, she was one of the
deities commonly invoked in private prayers and votive offerings, particularly by women desiring
children.
During the New Kingdom (c.15501070 BC), goddesses such as Mut and Isis encroached on
Hathor's position in royal ideology, but she remained one of the most widely worshipped deities.
After the end of the New Kingdom, Hathor was increasingly overshadowed by Isis, but she
continued to be venerated until the extinction of ancient Egyptian religion in the early centuries AD.
Information:
H 87.00 cm W 54.00 cm D/L 40.00 cm Dm Wt Old Kingdom Memphite Region Dynasty 4 Giza
Menkaure Pyramid Complex of Menkaure ca. 2490-2472 BC Valley Temple Source: Excavated by
G. Reisner for the Harvard University-BMFA Expedition in 1908 Notes: JE/SR: Schist; PM:
greywacke. SR: Excavation date 1903; JE: 1908.
Data Overview
Quartzite Head of an Amarna Princess (ID: JE 44869)
Summary:
The Amarna Princess, sometimes referred to as the "Bolton Amarna Princess," is a statue forged by
British art forger Shaun Greenhalgh and sold by his father George Sr. to Bolton Museum for
£440,000 in 2003. Based on the Amarna art-style of ancient Egypt, the purchase of the Amarna
Princess was feted as a "coup" by the museum and it remained on display for three years. However,
in November 2005, Greenhalgh was brought under suspicion by Scotland Yard's Arts and
Antiquities Unit, and the statue was impounded for further examination in March 2006. It is now
displayed as a part of an exhibition of fakes and forgeries.
Information:
H 19.00 cm W D/L Dm Wt New Kingdom Middle Egypt Dynasty 18 el-Amarna (Akhetaten)
Amenhotep IV / Akhenaten North of Wadi ca. 1353-1336 BC P.47.1-3: House of Thutmose
(Djehutymes) Source: Excavated by L. Borchardt for the DOG (Deutsche Orient-Gesellschaft) in
1912
Data Overview
Painted Wooden Model of a House, Garden and Pond of Meketre (ID: JE 46721)
Summary:
The ancient Egyptian official Meketre was chancellor and high steward during the reign of
Mentuhotep II, Mentuhotep III and perhaps Amenemhat I, during the Middle Kingdom.
Meketre is first attested in a rock inscription in the Wadi Shatt el-Rigala, bearing the simple title
sealer. The inscription is dated to year 41 of king Mentuhotep II. On reliefs from the mortuary temple
of the same king in Deir el-Bahari Meketre bears the title of chancellor and was evidently promoted
in the meantime, succeeding Kheti. The same title was found on a statue in Meketre's tomb while on
relief fragments in the tomb he held the main title of high steward. The tomb (TT280) is located in
Sheikh Abd el-Qurna, part of the Theban Necropolis, and lies next to a large, unfinished royal tomb
which was originally attributed to king Mentuhotep III and, after new research, to Amenemhat I.
Therefore, Meketre most likely died under the latter king.Meketre's tomb TT280 contained several
wooden replicas, representing the daily activities and life in Ancient Egypt, together with figurines of
ships and cattle were, miniature buildings and gardens. Selections of the replicas and other items
from the tomb are on display at the Metropolitan Museum of Art in New York City.
Information:
H 43.00 cm W 40.00 cm D/L 85.00 cm Dm Wt Middle Kingdom Thebes (Diospolis Magna; Luxor)
Dynasty 12 Thebes: West Deir el-Bahri ca. 1981-1802 BC TT280: Meketre Source: Excavated by H.
Winlock for the MMA (The Metropolitan Museum of Art) in 1920
Data Overview
Limestone Seated Statue of Djoser (Horus Netjerikhet) (ID: JE 49158)
Summary:
Djoser (also read as Djeser and Zoser) was an ancient Egyptian pharaoh of the 3rd Dynasty during
the Old Kingdom, and was the founder of that epoch. He is also known by his Hellenized names
Tosorthros (from Manetho) and Sesorthos (from Eusebius). He was the son of King Khasekhemwy
and Queen Nimaathap, but whether he was also the direct successor to their throne is unclear. Most
Ramesside king lists identify a king named Nebka as preceding him, but there are difficulties in
connecting that name with contemporary Horus names, so some Egyptologists question the
received throne sequence. Djoser is known for his step pyramid, which is the earliest colossal stone
building in ancient Egypt.
Information:
H 144.00 cm W 45.00 cm D/L 96.00 cm Dm Wt Old Kingdom Memphite Region Dynasty 3 Saqqara:
North Netjerikhet Djoser Pyramid Complex of Djoser ca. 2649-2630 BC Serdab Courtyard Source:
Excavated by C. Firth for the EAS (Egyptian Antiquities Service) in 1925
Data Overview
Colossal Sandstone Statue of Akhenaten: Head, Bust and Lower Feet (ID: JE 49528)
Summary:
Akhenaten (pronounced ), also spelled Akhenaton or Echnaton (Ancient Egyptian: -n-jtn -n-yty,
pronounced [u n jatj], meaning "Effective for the Aten"), was an ancient Egyptian pharaoh reigning
c.13531336 or 13511334 BC, the tenth ruler of the Eighteenth Dynasty. Before the fifth year of his
reign, he was known as Amenhotep IV (Ancient Egyptian: jmn-tp, meaning "Amun is satisfied",
Hellenized as Amenophis IV).
As a pharaoh, Akhenaten is noted for abandoning Egypt's traditional polytheism and introducing
Atenism, or worship centered around Aten. The views of Egyptologists differ as to whether the
religious policy was absolutely monotheistic, or whether it was monolatristic, syncretistic, or
henotheistic. This culture shift away from traditional religion was reversed after his death.
Akhenaten's monuments were dismantled and hidden, his statues were destroyed, and his name
excluded from lists of rulers compiled by later pharaohs. Traditional religious practice was gradually
restored, notably under his close successor Tutankhamun, who changed his name from
Tutankhaten early in his reign. When some dozen years later, rulers without clear rights of
succession from the Eighteenth Dynasty founded a new dynasty, they discredited Akhenaten and
his immediate successors and referred to Akhenaten as "the enemy" or "that criminal" in archival
records.Akhenaten was all but lost to history until the late-19th-century discovery of Amarna, or
Akhetaten, the new capital city he built for the worship of Aten. Furthermore, in 1907, a mummy that
could be Akhenaten's was unearthed from the tomb KV55 in the Valley of the Kings by Edward R.
Ayrton. Genetic testing has determined that the man buried in KV55 was Tutankhamun's father, but
its identification as Akhenaten has since been questioned.Akhenaten's rediscovery and Flinders
Petrie's early excavations at Amarna sparked great public interest in the pharaoh and his queen
Nefertiti. He has been described as "enigmatic", "mysterious", "revolutionary", "the greatest idealist
Data Overview
of the world", and "the first individual in history", but also as a "heretic", "fanatic", "possibly insane",
and "mad". Public and scholarly fascination with Akhenaten comes from his connection with
Tutankhamun, the unique style and high quality of the pictorial arts he patronized, and the religion
he attempted to establish, foreshadowing monotheism.
Information:
H 400.00 cm W 114.00 cm D/L 80.00 cm Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor)
Dynasty 18 Thebes: East Amenhotep IV / Akhenaten Karnak Temple (Ipet-Isut): Precinct of Aten ca.
1353-1336 BC Aten Colonnade Source: Excavated by H. Chevrier for the EAS (Egyptian Antiquities
Service) in 1925
Data Overview
Red Granite Sphinx of Hatshepsut (ID: JE 53114)
Summary:
Hatshepsut (c.15071458 BC) was the Great Royal Wife of Pharaoh Thutmose II and the fifth
Pharaoh of the Eighteenth Dynasty of Egypt, ruling first as regent, then as queen regnant from
c.1479 BC until c.1458 BC (Low Chronology). She was Egypt's second certain queen regnant, the
first being Sobekneferu/Nefrusobek in the Twelfth Dynasty.
Hatshepsut was the daughter of Thutmose I and his sister and Great Royal Wife Ahmose. Upon the
death of her husband and half-brother Thutmose II, she ruled initially as regent to her stepson
Thutmose III, who inherited the throne at the age of two. Several years into her regency, Hatshepsut
assumed the position of pharaoh and adopted the full royal titulary, making her a co-ruler alongside
Thutmose III. In order to establish herself in the Egyptian patriarchy, she took on traditionally male
roles and was depicted as a male pharaoh, with physically masculine traits and traditionally male
garb. Hatshepsut's reign was a period of great prosperity and general peace. One of the most
prolific builders in Ancient Egypt, she oversaw large-scale construction projects such as the Karnak
Temple Complex, the Red Chapel, the Speos Artemidos and most famously, the Mortuary Temple
of Hatshepsut at Deir el-Bahari.
Hatshepsut died probably in Year 22 of Thutmose III. Towards the end of the reign of Thutmose III
and into the reign of his son Amenhotep II, an attempt was made to remove her from official
accounts of Egyptian historiography. Her statues were destroyed, her monuments were defaced,
and many of her achievements were ascribed to other pharaohs. Many modern historians attribute
this to ritual and religious reasons, rather than personal hostility as previously thought.
Information:
H 145.00 cm W 98.00 cm D/L 260.00 cm Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor)
Data Overview
Dynasty 18 Thebes: West Hatshepsut Maatkare Deir el-Bahri ca. 1473-1458 BC Source: Excavated
for the MMA (The Metropolitan Museum of Art) in 1929
Data Overview
Sandstone Colossal Statue of Amenhotep IV/Akhenaten (ID: JE 55938)
Summary:
Akhenaten (pronounced ), also spelled Akhenaton or Echnaton (Ancient Egyptian: -n-jtn -n-yty,
pronounced [u n jatj], meaning "Effective for the Aten"), was an ancient Egyptian pharaoh reigning
c.13531336 or 13511334 BC, the tenth ruler of the Eighteenth Dynasty. Before the fifth year of his
reign, he was known as Amenhotep IV (Ancient Egyptian: jmn-tp, meaning "Amun is satisfied",
Hellenized as Amenophis IV).
As a pharaoh, Akhenaten is noted for abandoning Egypt's traditional polytheism and introducing
Atenism, or worship centered around Aten. The views of Egyptologists differ as to whether the
religious policy was absolutely monotheistic, or whether it was monolatristic, syncretistic, or
henotheistic. This culture shift away from traditional religion was reversed after his death.
Akhenaten's monuments were dismantled and hidden, his statues were destroyed, and his name
excluded from lists of rulers compiled by later pharaohs. Traditional religious practice was gradually
restored, notably under his close successor Tutankhamun, who changed his name from
Tutankhaten early in his reign. When some dozen years later, rulers without clear rights of
succession from the Eighteenth Dynasty founded a new dynasty, they discredited Akhenaten and
his immediate successors and referred to Akhenaten as "the enemy" or "that criminal" in archival
records.Akhenaten was all but lost to history until the late-19th-century discovery of Amarna, or
Akhetaten, the new capital city he built for the worship of Aten. Furthermore, in 1907, a mummy that
could be Akhenaten's was unearthed from the tomb KV55 in the Valley of the Kings by Edward R.
Ayrton. Genetic testing has determined that the man buried in KV55 was Tutankhamun's father, but
its identification as Akhenaten has since been questioned.Akhenaten's rediscovery and Flinders
Petrie's early excavations at Amarna sparked great public interest in the pharaoh and his queen
Nefertiti. He has been described as "enigmatic", "mysterious", "revolutionary", "the greatest idealist
Data Overview
of the world", and "the first individual in history", but also as a "heretic", "fanatic", "possibly insane",
and "mad". Public and scholarly fascination with Akhenaten comes from his connection with
Tutankhamun, the unique style and high quality of the pictorial arts he patronized, and the religion
he attempted to establish, foreshadowing monotheism.
Information:
H 295.00 cm W D/L Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor) Dynasty 18 Thebes:
East Amenhotep IV / Akhenaten Karnak Temple (Ipet-Isut): Precinct of Aten ca. 1353-1336 BC Aten
Colonnade Source: Excavated by H. Chevrier for the EAS (Egyptian Antiquities Service) in 1925
Data Overview
Painted Limestone Head of a Colossal Statue of Hatshepsut (ID: JE 56262)
Summary:
Hatshepsut (c.15071458 BC) was the Great Royal Wife of Pharaoh Thutmose II and the fifth
Pharaoh of the Eighteenth Dynasty of Egypt, ruling first as regent, then as queen regnant from
c.1479 BC until c.1458 BC (Low Chronology). She was Egypt's second certain queen regnant, the
first being Sobekneferu/Nefrusobek in the Twelfth Dynasty.
Hatshepsut was the daughter of Thutmose I and his sister and Great Royal Wife Ahmose. Upon the
death of her husband and half-brother Thutmose II, she ruled initially as regent to her stepson
Thutmose III, who inherited the throne at the age of two. Several years into her regency, Hatshepsut
assumed the position of pharaoh and adopted the full royal titulary, making her a co-ruler alongside
Thutmose III. In order to establish herself in the Egyptian patriarchy, she took on traditionally male
roles and was depicted as a male pharaoh, with physically masculine traits and traditionally male
garb. Hatshepsut's reign was a period of great prosperity and general peace. One of the most
prolific builders in Ancient Egypt, she oversaw large-scale construction projects such as the Karnak
Temple Complex, the Red Chapel, the Speos Artemidos and most famously, the Mortuary Temple
of Hatshepsut at Deir el-Bahari.
Hatshepsut died probably in Year 22 of Thutmose III. Towards the end of the reign of Thutmose III
and into the reign of his son Amenhotep II, an attempt was made to remove her from official
accounts of Egyptian historiography. Her statues were destroyed, her monuments were defaced,
and many of her achievements were ascribed to other pharaohs. Many modern historians attribute
this to ritual and religious reasons, rather than personal hostility as previously thought.
Information:
H 61.00 cm W 55.00 cm D/L 80.00 cm Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor)
Data Overview
Dynasty 18 Thebes: West Hatshepsut Maatkare Deir el-Bahri ca. 1473-1458 BC Mortuary Temple of
Hatshepsut Source: Excavated by H. Winlock for the MMA (The Metropolitan Museum of Art) in
1926
Data Overview
Quartzite Unfinished Head of Nefertiti (ID: JE 59286)
Summary:
Nefertiti () (c.1370 c.1330 BC) was a queen of the 18th Dynasty of Ancient Egypt, the great royal
wife of Pharaoh Akhenaten. Nefertiti and her husband were known for their radical overhaul of state
religious policy, in which they promoted the earliest known form of monotheism, Atenism, centered
on the sun disc and its direct connection to the royal household. With her husband, she reigned at
what was arguably the wealthiest period of ancient Egyptian history. Some scholars believe that
Nefertiti ruled briefly as Neferneferuaten after her husband's death and before the ascension of
Tutankhamun, although this identification is a matter of ongoing debate. If Nefertiti did rule as
Pharaoh, her reign was marked by the fall of Amarna and relocation of the capital back to the
traditional city of Thebes.She was made famous by her bust, now in Berlin's Neues Museum. The
bust is one of the most copied works of art of ancient Egypt. It was attributed to the sculptor
Thutmose, and it was found in his workshop.
Information:
H 36.00 cm W 11.00 cm D/L 17.00 cm Dm Wt New Kingdom Middle Egypt Dynasty 18 el-Amarna
(Akhetaten) Amenhotep IV / Akhenaten North of Wadi ca. 1353-1336 BC O.46.16a&20: Houses
Source: Excavated by J. Pendlebury for the EES (Egypt Exploration Society) in 1932
Data Overview
Canopic Chest of Akhenaten (ID: JE 59454)
Summary:
Akhenaten (pronounced ), also spelled Akhenaton or Echnaton (Ancient Egyptian: -n-jtn -n-yty,
pronounced [u n jatj], meaning "Effective for the Aten"), was an ancient Egyptian pharaoh reigning
c.13531336 or 13511334 BC, the tenth ruler of the Eighteenth Dynasty. Before the fifth year of his
reign, he was known as Amenhotep IV (Ancient Egyptian: jmn-tp, meaning "Amun is satisfied",
Hellenized as Amenophis IV).
As a pharaoh, Akhenaten is noted for abandoning Egypt's traditional polytheism and introducing
Atenism, or worship centered around Aten. The views of Egyptologists differ as to whether the
religious policy was absolutely monotheistic, or whether it was monolatristic, syncretistic, or
henotheistic. This culture shift away from traditional religion was reversed after his death.
Akhenaten's monuments were dismantled and hidden, his statues were destroyed, and his name
excluded from lists of rulers compiled by later pharaohs. Traditional religious practice was gradually
restored, notably under his close successor Tutankhamun, who changed his name from
Tutankhaten early in his reign. When some dozen years later, rulers without clear rights of
succession from the Eighteenth Dynasty founded a new dynasty, they discredited Akhenaten and
his immediate successors and referred to Akhenaten as "the enemy" or "that criminal" in archival
records.Akhenaten was all but lost to history until the late-19th-century discovery of Amarna, or
Akhetaten, the new capital city he built for the worship of Aten. Furthermore, in 1907, a mummy that
could be Akhenaten's was unearthed from the tomb KV55 in the Valley of the Kings by Edward R.
Ayrton. Genetic testing has determined that the man buried in KV55 was Tutankhamun's father, but
its identification as Akhenaten has since been questioned.Akhenaten's rediscovery and Flinders
Petrie's early excavations at Amarna sparked great public interest in the pharaoh and his queen
Nefertiti. He has been described as "enigmatic", "mysterious", "revolutionary", "the greatest idealist
Data Overview
of the world", and "the first individual in history", but also as a "heretic", "fanatic", "possibly insane",
and "mad". Public and scholarly fascination with Akhenaten comes from his connection with
Tutankhamun, the unique style and high quality of the pictorial arts he patronized, and the religion
he attempted to establish, foreshadowing monotheism.
Information:
H W D/L 58.50 cm Dm Wt New Kingdom Middle Egypt Dynasty 18 el-Amarna (Akhetaten)
Amenhotep IV / Akhenaten Royal Wadi ca. 1353-1336 BC 26: Royal Tomb Source: Excavated by J.
Pendlebury for the EES (Egypt Exploration Society) in 1932
Data Overview
Granodiorite Statue of Ramesses II as Child Protected by the God Horun (ID: JE 64735)
Summary:
Ramesses II (; Ancient Egyptian: r-ms-sw, Ra-mas-s, Semitic pronunciation: [iamases]; c.1303 BC
1213 BC), commonly known as Ramesses the Great, was an Egyptian pharaoh. He was the third
ruler of the Nineteenth Dynasty. Along with Thutmose III of the Eighteenth Dynasty, he is often
regarded as the greatest, most celebrated, and most powerful pharaoh of the New Kingdom, which
itself was the most powerful period of ancient Egypt. He is also widely considered one of ancient
Egypt's most successful warrior pharaohs, conducting no fewer than 15 military campaigns, all
resulting in victories, excluding the Battle of Kadesh, generally considered a stalemate.In ancient
Greek sources, he is called Ozymandias, derived from the first part of his Egyptian-language regnal
name: Usermaatre Setepenre. Ramesses was also referred to as the "Great Ancestor" by successor
pharaohs and the Egyptian people.
For the early part of his reign, he focused on building cities, temples, and monuments. After
establishing the city of Pi-Ramesses in the Nile Delta, he designated it as Egypt's new capital and
used it as the main staging point for his campaigns in Syria. Ramesses led several military
expeditions into the Levant, where he reasserted Egyptian control over Canaan and Phoenicia; he
also led a number of expeditions into Nubia, all commemorated in inscriptions at Beit el-Wali and
Gerf Hussein. He celebrated an unprecedented thirteen or fourteen Sed festivalsmore than any
other pharaoh.Estimates of his age at death vary, though 90 or 91 is considered to be the most
likely figure. Upon his death, he was buried in a tomb (KV7) in the Valley of the Kings; his body was
later moved to the Royal Cache, where it was discovered by archaeologists in 1881. Ramesses'
mummy is now on display at the National Museum of Egyptian Civilization, located in the city of
Cairo.
Data Overview
Information:
H 200.00 cm W 66.00 cm D/L 132.00 cm Dm Wt New Kingdom Delta: Eastern Dynasty 19 San
el-Hagar (Djanet; Tanis) Ramesses II Usermaatre Setepenre Subsidiary Buildings ca. 1279-1213
BC Chapel of Horun Source: Excavated by P. Montet for the IFAO (French Institute of Oriental
Archaeology) in 1933
Data Overview
Limestone Altar from the House of Panehsy with Akhenaten and his Family Worshipping the Aten (ID: Summary:
Panehesy (also transcribed as Pinhasy or Panehsy) was an Egyptian noble who bore the titles of
'Chief servitor of the Aten in the temple of Aten in Akhetaten' ('Second Prophet of the Lord of the
Two Lands'). END OF TEXT Akhenaten (pronounced ), also spelled Akhenaton or Echnaton
(Ancient Egyptian: -n-jtn -n-yty, pronounced [u n jatj], meaning "Effective for the Aten"), was an
ancient Egyptian pharaoh reigning c.13531336 or 13511334 BC, the tenth ruler of the Eighteenth
Dynasty. Before the fifth year of his reign, he was known as Amenhotep IV (Ancient Egyptian:
jmn-tp, meaning "Amun is satisfied", Hellenized as Amenophis IV).
As a pharaoh, Akhenaten is noted for abandoning Egypt's traditional polytheism and introducing
Atenism, or worship centered around Aten. The views of Egyptologists differ as to whether the
religious policy was absolutely monotheistic, or whether it was monolatristic, syncretistic, or
henotheistic. This culture shift away from traditional religion was reversed after his death.
Akhenaten's monuments were dismantled and hidden, his statues were destroyed, and his name
excluded from lists of rulers compiled by later pharaohs. Traditional religious practice was gradually
restored, notably under his close successor Tutankhamun, who changed his name from
Tutankhaten early in his reign. When some dozen years later, rulers without clear rights of
succession from the Eighteenth Dynasty founded a new dynasty, they discredited Akhenaten and
his immediate successors and referred to Akhenaten as "the enemy" or "that criminal" in archival
records.Akhenaten was all but lost to history until the late-19th-century discovery of Amarna, or
Akhetaten, the new capital city he built for the worship of Aten. Furthermore, in 1907, a mummy that
could be Akhenaten's was unearthed from the tomb KV55 in the Valley of the Kings by Edward R.
Ayrton. Genetic testing has determined that the man buried in KV55 was Tutankhamun's father, but
its identification as Akhenaten has since been questioned.Akhenaten's rediscovery and Flinders
Data Overview
Petrie's early excavations at Amarna sparked great public interest in the pharaoh and his queen
Nefertiti. He has been described as "enigmatic", "mysterious", "revolutionary", "the greatest idealist
of the world", and "the first individual in history", but also as a "heretic", "fanatic", "possibly insane",
and "mad". Public and scholarly fascination with Akhenaten comes from his connection with
Tutankhamun, the unique style and high quality of the pictorial arts he patronized, and the religion
he attempted to establish, foreshadowing monotheism. END OF TEXT Aten also Aton, Atonu, or Itn
(Ancient Egyptian: jtn, reconstructed [jatin]) was the focus of Atenism, the religious system formally
established in ancient Egypt by the late Eighteenth Dynasty pharaoh Akhenaten. Exact dating for
the 18th dynasty is contested, though a general date range places the dynasty in the years 1550 to
1292 B.C.E. The worship of Aten and the coinciding rule of Akhenaten are major identifying
characteristics of a period within the 18th dynasty referred to as the Amarna Period (c. 13531336
B.C.E.).Atenism and the worship of the Aten as the sole god of ancient Egypt state worship did not
persist beyond Akhenaten's death. Not long after his death, one of Akhenaten's 18th dynasty
successors, Tutankhamun, reopened the state temples to other Egyptian gods and re-positioned
Amun as the preeminent solar deity. He is depicted as a solar disk emitting rays terminating human
hands.
Information:
H 98.00 cm W 118.00 cm D/L Dm Wt New Kingdom Middle Egypt Dynasty 18 el-Amarna
(Akhetaten) Amenhotep IV / Akhenaten Central City ca. 1353-1336 BC T41.1: Official Residence of
Panehsy Source: Excavated by H. Frankfort for the EES (Egypt Exploration Society) in 1926
Data Overview
Wooden Outer Anthropoid Coffin of Yuya (ID: JE 68960)
Summary:
Yuya (sometimes Iouiya, or Yuaa, also known as Yaa, Ya, Yiya, Yayi, Yu, Yuyu, Yaya, Yiay, Yia,
and Yuy) was a powerful ancient Egyptian courtier during the Eighteenth Dynasty of Egypt (circa
1390 BC). He was married to Thuya, an Egyptian noblewoman associated with the royal family, who
held high offices in the governmental and religious hierarchies. Their daughter, Tiye, became the
Great Royal Wife of Amenhotep III. Yuya and Thuya are known to have had a son named Anen,
who carried the titles "Chancellor of Lower Egypt", "Second Prophet of Amun", "Sm-priest of
Heliopolis", and "Divine Father".They may also have been the parents of Ay, an Egyptian courtier
active during the reign of Akhenaten, who eventually became pharaoh as Kheperkheprure Ay. There
is no conclusive evidence, however, regarding the kinship of Yuya and Ay, although certainly both
men came from the town of Akhmim.The tomb of Yuya and Thuya was, until the discovery of
Tutankhamun's, one of the most spectacular ever found in the Valley of the Kings despite Yuya not
being a pharaoh. Although the burial site was robbed in antiquity, many objects not considered
worth plundering by the robbers remained. Both the mummies were largely intact and were in an
amazing state of preservation. Their faces in particular were relatively undistorted by the process of
mummification, and provide an extraordinary insight into the actual appearance of the deceased
while alive (see photographs).
Information:
H 126.00 cm W 105.00 cm D/L 275.00 cm Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor)
Dynasty 18 Thebes: West Amenhotep III Nebmaatre Valley of the Kings (Biban el-Muluk) ca.
1390-1352 BC KV46: Yuya and Tjuya Source: Excavated by J. Quibell for Theodore Davis in 1905
Data Overview
Gold Pectoral of Sheshonq II with Lapis Lazuli Scarab (ID: JE 72172)
Summary:
Heqakheperre Shoshenq II or Shoshenq IIa was a pharaoh of the Twenty-second Dynasty of Egypt.
He was the only ruler of this dynasty whose tomb was not plundered by tomb robbers. His final
resting place was discovered within an antechamber of Psusennes I's tomb at Tanis by Pierre
Montet in 1939. Montet removed the coffin lid of Shoshenq II on March 20, 1939, in the presence of
king Farouk of Egypt himself. It proved to contain many jewel-encrusted bracelets and pectorals,
along with a beautiful hawkheaded silver coffin and a gold funerary mask. The facemask had been
placed upon the head of the king. Montet later discovered the intact tombs of two Twenty-first
Dynasty kings (Psusennes I and Amenemope) a year later in February and April 1940 respectively.
Shoshenq II's prenomen, Heqakheperre Setepenre, means "The manifestation of Ra rules, the
chosen one of Ra."
Information:
H 7.00 cm W 5.30 cm D/L Dm Wt 48.05 gr 3rd Intermediate Period Delta: Eastern Dynasty 22 San
el-Hagar (Djanet; Tanis) Sheshonq II Heqakheperre Setepenre Tanis Royal Tombs ca. 890 BC
Tomb III: Psusennes I Source: Excavated by P. Montet for the Louvre Museum in 1939
Data Overview
Silver Anthropoid Inner Coffin of Psusennes I (ID: JE 85912)
Summary:
Psusennes I (Ancient Egyptian: p-sb--n-njwt; Greek ) was the third pharaoh of the 21st Dynasty who
ruled from Tanis between 1047 and 1001 BC. Psusennes is the Greek version of his original name
Pasibkhanu or Pasebakhaenniut (in reconstructed Late Egyptian: /psiwenne/), which means "The
Star Appearing in the City" while his throne name, Akheperre Setepenamun, translates as "Great
are the Manifestations of Ra, chosen of Amun." He was the son of Pinedjem I and Henuttawy,
Ramesses XI's daughter by Tentamun. He married his sister Mutnedjmet.
Psusennes's tomb, discovered in 1940, is notable for the condition in which it was found. Almost all
pharaonic tombs were entirely graverobbed but Psuennes's tomb was one of only two royal tombs
discovered in fully intact condition, the other being the tomb of Pharaoh Amenemope. However, the
humid climate of Lower Egypt meant only the metal objects had survived.
Information:
H 42.00 cm W 60.00 cm D/L 185.00 cm Dm Wt 3rd Intermediate Period Delta: Eastern Dynasty 21
San el-Hagar (Djanet; Tanis) Psusennes I Pasebakhaenniut Aakheperre Tanis Royal Tombs ca.
1040-992 BC Tomb III: Psusennes I Source: Excavated by P. Montet for the Louvre Museum in
1940
Data Overview
Silver Libation Vase of Amenemope Beloved of Osiris (ID: JE 86099)
Summary:
Osiris (, from Egyptian wsjr) is the god of fertility, agriculture, the afterlife, the dead, resurrection, life,
and vegetation in ancient Egyptian religion. He was classically depicted as a green-skinned deity
with a pharaoh's beard, partially mummy-wrapped at the legs, wearing a distinctive atef crown, and
holding a symbolic crook and flail. He was one of the first to be associated with the mummy wrap.
When his brother Set cut him up into pieces after killing him, Osiris' wife Isis found all the pieces and
wrapped his body up, enabling him to return to life. Osiris was widely worshipped until the decline of
ancient Egyptian religion during the rise of Christianity in the Roman Empire.Osiris was at times
considered the eldest son of the earth god Geb and the sky goddess Nut, as well as being brother
and husband of Isis, and brother of Set, Nephthys, and Horus the Elder, with Horus the Younger
being considered his posthumously begotten son. Through syncretism with Iah, he was also a god
of the Moon.Osiris was the judge and lord of the dead and the underworld, the "Lord of Silence" and
Khenti-Amentiu, meaning "Foremost of the Westerners". In the Old Kingdom (26862181 BC) the
pharaoh was considered a son of the sun god Ra who, after his death, ascended to join Ra in the
sky. After the spread of the Osiris cult, however, the kings of Egypt were associated with Osiris in
death as Osiris rose from the dead, they would unite with him and inherit eternal life through
imitative magic.Through the hope of new life after death, Osiris began to be associated with the
cycles in nature, in particular the sprouting of vegetation and the annual flooding of the Nile River,
as well as the heliacal rising of Orion and Sirius at the start of the new year. He became the
sovereign that granted all life, "He Who is Permanently Benign and Youthful".The first evidence of
the worship of Osiris is from the middle of the Fifth Dynasty of Egypt (25th century BC), although it is
likely that he was worshiped much earlier; the Khenti-Amentiu epithet dates to at least the First
Dynasty, and was also used as a pharaonic title. Most information available on the Osiris myth is
Data Overview
derived from allusions in the Pyramid Texts at the end of the Fifth Dynasty, later New Kingdom
source documents such as the Shabaka Stone and "The Contendings of Horus and Seth", and
much later, in the narratives of Greek authors including Plutarch and Diodorus Siculus.Some
Egyptologists believe the Osiris mythos may have originated in a former living ruler possibly a
shepherd who lived in Predynastic times (55003100 BC) in the Nile Delta, whose beneficial rule led
to him being revered as a god. The accoutrements of the shepherd, the crook and the flail once
insignia of the Delta god Andjety, with whom Osiris was associated support this theory.
Information:
H 12.50 cm W D/L Dm Wt 218.00 gr 3rd Intermediate Period Delta: Eastern Dynasty 21 San
el-Hagar (Djanet; Tanis) Amenemope Usermaatre Setepenre Tanis Royal Tombs ca. 993-984 BC
Tomb IV: Amenemope Source: Excavated by P. Montet for the Louvre Museum in 1940
Data Overview
Golden Flying Ba Bird Amulet, of Prince Hornakht (ID: JE 87147)
Summary:
Prince Hornakht (or Harnakht) was the son of pharaoh Osorkon II of the 22nd Dynasty. He was
appointed by Osorkon II to the office of chief priest of Amun at Tanis to strengthen this king's
authority in Lower Egypt. However, this was primarily a political move on Osorkon II's part since
Hornakht died before the age of 10.When Hornakht died at this young age, Osorkon II made
provisions to ensure that his son would be buried in this king's own tomb at Tanis. While tomb
robbers managed to penetrate the burial of Hornakht in antiquity, his sarcophagus still preserved
parts of the tomb treasures which were once placed upon the prince's mummy since a large granite
block placed over Hornakht's burial prevented them from lifting its lid completely. Secondly, most of
the grave robbers attention were focused upon the sarcophagus of Osorkon II which would have
featured vastly more splendid treasures.The grave robbers succeeded in removing the gold funerary
mask which covered Hornakht's face as well as some ornaments which adorned his neck; however,
they abandoned their efforts to steal the remainder of the prince's funerary treasures. Therefore,
when Egyptologist Pierre Montet discovered the burial of Hornakht, they found a series of gold
amulets which covered parts of the prince's mummy. They are small in size but enjoy a high quality
finish; some are made of gold partitioned lapis lazuli and other semi-precious stones which
represent various mythical symbols intended to safeguard the sanctity of Hornakht's mummified
body.According to the analysis of his skeleton performed in 1942 by Dr. Douglas Derry, Hornakht
died aged 89. On the remains some peculiarities were noted, such as an unusually large and
developed skull for his age, the presence of a pair of cervical ribs, and an abnormal lumbar vertebra;
however, Derry excluded that these anomalies may have led to Hornakht's premature death. Part of
the face was damaged by embalmers during the brain removal by the nose.A block statue from the
Serapeum at Saqqara may well have been dedicated to Hornakht. The statue is decorated with
Data Overview
relief images of queen Karomama I, Hornakhts mother, and of the god Amun-Ra (besides other
divinities). The sculpture now has a figure of Osiris at the front (re-cut from what appears to have
represented a naos once) and was probably set up not long after the princes premature death.
Information:
H W 8.00 cm D/L Dm Wt 9.16 gr 3rd Intermediate Period Delta: Eastern Dynasty 22 San el-Hagar
(Djanet; Tanis) Osorkon II Usermaatre Setepenamun Tanis Royal Tombs ca. 874-850 BC Tomb I:
Osorkon II Source: Excavated by P. Montet for the Louvre Museum in 1940
Data Overview
Grey Granite Balustrade with Akhenaten, Nefertiti and Meritaten Adoring the Aten (ID: JE 87300)
Summary:
Akhenaten (pronounced ), also spelled Akhenaton or Echnaton (Ancient Egyptian: -n-jtn -n-yty,
pronounced [u n jatj], meaning "Effective for the Aten"), was an ancient Egyptian pharaoh reigning
c.13531336 or 13511334 BC, the tenth ruler of the Eighteenth Dynasty. Before the fifth year of his
reign, he was known as Amenhotep IV (Ancient Egyptian: jmn-tp, meaning "Amun is satisfied",
Hellenized as Amenophis IV).
As a pharaoh, Akhenaten is noted for abandoning Egypt's traditional polytheism and introducing
Atenism, or worship centered around Aten. The views of Egyptologists differ as to whether the
religious policy was absolutely monotheistic, or whether it was monolatristic, syncretistic, or
henotheistic. This culture shift away from traditional religion was reversed after his death.
Akhenaten's monuments were dismantled and hidden, his statues were destroyed, and his name
excluded from lists of rulers compiled by later pharaohs. Traditional religious practice was gradually
restored, notably under his close successor Tutankhamun, who changed his name from
Tutankhaten early in his reign. When some dozen years later, rulers without clear rights of
succession from the Eighteenth Dynasty founded a new dynasty, they discredited Akhenaten and
his immediate successors and referred to Akhenaten as "the enemy" or "that criminal" in archival
records.Akhenaten was all but lost to history until the late-19th-century discovery of Amarna, or
Akhetaten, the new capital city he built for the worship of Aten. Furthermore, in 1907, a mummy that
could be Akhenaten's was unearthed from the tomb KV55 in the Valley of the Kings by Edward R.
Ayrton. Genetic testing has determined that the man buried in KV55 was Tutankhamun's father, but
its identification as Akhenaten has since been questioned.Akhenaten's rediscovery and Flinders
Petrie's early excavations at Amarna sparked great public interest in the pharaoh and his queen
Nefertiti. He has been described as "enigmatic", "mysterious", "revolutionary", "the greatest idealist
Data Overview
of the world", and "the first individual in history", but also as a "heretic", "fanatic", "possibly insane",
and "mad". Public and scholarly fascination with Akhenaten comes from his connection with
Tutankhamun, the unique style and high quality of the pictorial arts he patronized, and the religion
he attempted to establish, foreshadowing monotheism. END OF TEXT Nefertiti () (c.1370 c.1330
BC) was a queen of the 18th Dynasty of Ancient Egypt, the great royal wife of Pharaoh Akhenaten.
Nefertiti and her husband were known for their radical overhaul of state religious policy, in which
they promoted the earliest known form of monotheism, Atenism, centered on the sun disc and its
direct connection to the royal household. With her husband, she reigned at what was arguably the
wealthiest period of ancient Egyptian history. Some scholars believe that Nefertiti ruled briefly as
Neferneferuaten after her husband's death and before the ascension of Tutankhamun, although this
identification is a matter of ongoing debate. If Nefertiti did rule as Pharaoh, her reign was marked by
the fall of Amarna and relocation of the capital back to the traditional city of Thebes.She was made
famous by her bust, now in Berlin's Neues Museum. The bust is one of the most copied works of art
of ancient Egypt. It was attributed to the sculptor Thutmose, and it was found in his workshop.
END OF TEXT Meritaten, also spelled Merytaten, Meritaton or Meryetaten (Ancient Egyptian:
mrii.t-itn) (14th century BC), was an ancient Egyptian royal woman of the Eighteenth Dynasty of
Egypt. Her name means "She who is beloved of Aten"; Aten being the sun-deity whom her father,
Pharaoh Akhenaten, worshipped. She held several titles, performing official roles for her father and
becoming the Great Royal Wife to Pharaoh Smenkhkare, who may have been a brother or son of
Akhenaten. Meritaten also may have served as pharaoh in her own right under the name
Ankhkheperure Neferneferuaten. END OF TEXT Aten also Aton, Atonu, or Itn (Ancient Egyptian: jtn,
reconstructed [jatin]) was the focus of Atenism, the religious system formally established in ancient
Egypt by the late Eighteenth Dynasty pharaoh Akhenaten. Exact dating for the 18th dynasty is
contested, though a general date range places the dynasty in the years 1550 to 1292 B.C.E. The
Data Overview
worship of Aten and the coinciding rule of Akhenaten are major identifying characteristics of a period
within the 18th dynasty referred to as the Amarna Period (c. 13531336 B.C.E.).Atenism and the
worship of the Aten as the sole god of ancient Egypt state worship did not persist beyond
Akhenaten's death. Not long after his death, one of Akhenaten's 18th dynasty successors,
Tutankhamun, reopened the state temples to other Egyptian gods and re-positioned Amun as the
preeminent solar deity. He is depicted as a solar disk emitting rays terminating human hands.
Information:
H 121.00 cm W 51.00 cm D/L 43.00 cm Dm Wt New Kingdom Middle Egypt Dynasty 18
el-Ashmunein (Hermopolis Magna; Khmun) Amenhotep IV / Akhenaten el-Ashmunein ca.
1353-1336 BC Late Gate Source: Excavated by G. Roeder for the Hildesheim Expedition in 1931
Data Overview
Gold and Lapis Lazuli Pendant of Wendjebauendjedet: Ptah in His Shrine (ID: JE 87712)
Summary:
Ptah (Ancient Egyptian: pt, reconstructed [pita]; Ancient Greek: ; Coptic: ; Phoenician: , romanized:
pt) is an ancient Egyptian deity, a creator god and patron deity of craftsmen and architects. In the
triad of Memphis, he is the husband of Sekhmet and the father of Nefertem. He was also regarded
as the father of the sage Imhotep.
Information:
H 6.00 cm W 3.00 cm D/L 1.70 cm Dm Wt 3rd Intermediate Period Delta: Eastern Dynasty 21 San
el-Hagar (Djanet; Tanis) Psusennes I Pasebakhaenniut Aakheperre Tanis Royal Tombs ca.
1040-992 BC Tomb III: Psusennes I Source: Excavated by P. Montet for the Louvre Museum in
1946
Data Overview
Schist Statue Head of Userkaf in the Red Crown (ID: JE 90220)
Summary:
Userkaf (known in Ancient Greek as , Usercherês) was a pharaoh of ancient Egypt and the founder
of the Fifth Dynasty. He reigned for seven to eight years in the early 25th century BC, during the Old
Kingdom period. He probably belonged to a branch of the Fourth Dynasty royal family, although his
parentage is uncertain; he could have been the son of Khentkaus I. He had at least one daughter
and very probably a son, Sahure, with his consort Neferhetepes. This son succeeded him as
pharaoh.
His reign heralded the ascendancy of the cult of Ra, who effectively became Egypt's state god
during the Fifth Dynasty. Userkaf may have been a high-priest of Ra before ascending the throne,
and built a sun temple, known as the Nekhenre, between Abusir and Abu Gurab. In doing so, he
instituted a tradition followed by his successors over a period of 80 years. The Nekhenre mainly
functioned as a mortuary temple for the setting sun. Rites performed in the temple were primarily
concerned with Ra's creator function and his role as father of the king. Taken with the reduction in
the size of the royal mortuary complex, this suggests a more concrete separation between the sun
god and the king than in the preceding dynasties. After Userkaf's death, his temple was the subject
of four building phases, during which it acquired a large obelisk.
Userkaf built a pyramid in Saqqara close to that of Djoser, a location that forced architects to put the
associated mortuary temple in an unusual position, to the south of the pyramid. The latter was much
smaller than those built during the Fourth Dynasty but the mortuary complex was lavishly and
extensively decorated with fine painted reliefs. In addition to his own pyramid and temple, Userkaf
built a smaller pyramid close to his for one of his queens, likely Neferhetepes. Although Userkaf was
the object of a funerary cult after his death like the other Fifth Dynasty kings, his was relatively
Data Overview
unimportant, and was abandoned after the end of the dynasty. Little is known of his activities
beyond the construction of his pyramid and sun temple. The Old Kingdom royal annals record
offerings of beer, bread and lands to various gods, some of which may correspond to building
projects on Userkaf's behalf, including the temple of Montu in El-Tod where he is the earliest
attested pharaoh. Beyond the borders of Egypt, a military expedition to Canaan or the Eastern
Desert may have taken place, and trade contacts with the Aegean seem to have existed at the time.
Information:
H 38.00 cm W 25.00 cm D/L Dm Wt Old Kingdom Memphite Region Dynasty 5 Abusir Userkaf Sun
Temple of Userkaf ca. 2465-2458 BC Source: Excavated by H. Ricke for the Swiss Institute, the
DAIK (German Archaeological Institute) in 1957
Data Overview
Granodiorite Standing Statue of Queen Tiye with Flywhisk, Usurped by Henuttawy (ID: JE 99281)
Summary:
Tiye (c. 1398 BC 1338 BC, also spelled Tye, Taia, Tiy and Tiyi) was the Great Royal Wife of the
Egyptian pharaoh Amenhotep III, mother of pharaoh Akhenaten and grandmother of pharaoh
Tutankhamun; her parents were Yuya and Thuya. In 2010, DNA analysis confirmed her as the
mummy known as "The Elder Lady" found in the tomb of Amenhotep II (KV35) in 1898.
Information:
H 160.00 cm W 51.00 cm D/L 41.00 cm Dm Wt New Kingdom Thebes (Diospolis Magna; Luxor)
Dynasty 18 Thebes: East Amenhotep III Nebmaatre Karnak Temple (Ipet-Isut): Precinct of Mut ca.
1390-1352 BC Temple of Mut Source: Excavated by B. Bryan for The Johns Hopkins University in
2006
''';
