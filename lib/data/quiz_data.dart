import 'dart:math';
import '../models/question_model.dart';

class QuizData {
  static final Map<String, Map<String, dynamic>> _quizzes = {
    'HTML Crash Quiz': {
      'imagePath': 'assets/images/html.png',
      'category': 'Technology',
      'questionCount': 10,
      'questions': [
        {
          'question': 'Apa singkatan dari HTML?',
          'options': [
            'HyperText Markup Language',
            'Hyper Tool Markup Language',
            'Home Tool Markup Language',
            'Hyper Transfer Markup Language'
          ],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag untuk membuat link adalah?',
          'options': ['<link>', '<a>', '<href>', '<url>'],
          'correctAnswerIndex': 1
        },
        {
          'question': 'HTML pertama kali dirilis tahun?',
          'options': ['1990', '1991', '1995', '2000'],
          'correctAnswerIndex': 1
        },
        {
          'question': 'Tanda komentar di HTML adalah?',
          'options': ['<!-- -->', '/* */', '//', '#'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag <img> digunakan untuk?',
          'options': ['Menampilkan gambar', 'Membuat hyperlink', 'Membuat paragraf', 'Membuat tabel'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Atribut “alt” pada <img> digunakan untuk?',
          'options': [
            'Teks alternatif jika gambar gagal dimuat',
            'Ukuran gambar',
            'Lokasi gambar',
            'Menentukan format gambar'
          ],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag untuk membuat list bernomor adalah?',
          'options': ['<ol>', '<ul>', '<li>', '<list>'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag heading terbesar adalah?',
          'options': ['<h1>', '<h3>', '<h6>', '<heading>'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag paragraf dalam HTML adalah?',
          'options': ['<para>', '<p>', '<pg>', '<paragraph>'],
          'correctAnswerIndex': 1
        },
        {
          'question': 'Tag apa yang digunakan untuk membuat tabel?',
          'options': ['<table>', '<tab>', '<td>', '<tr>'],
          'correctAnswerIndex': 0,
          'image': 'assets/images/html_table_example.png'
        },
        {
          'question': 'Tag <tr> berfungsi untuk?',
          'options': ['Baris tabel', 'Kolom tabel', 'Isi tabel', 'Judul tabel'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag <td> digunakan untuk?',
          'options': ['Baris tabel', 'Sel tabel', 'Judul tabel', 'Isi gambar'],
          'correctAnswerIndex': 1
        },
        {
          'question': 'Tag <form> digunakan untuk?',
          'options': ['Membuat form input', 'Menampilkan teks', 'Menentukan layout', 'Membuat gambar'],
          'correctAnswerIndex': 0,
          'image': 'assets/images/html_form_example.png'
        },
        {
          'question': 'Atribut method dalam form bisa berupa?',
          'options': ['GET dan POST', 'PUT dan PATCH', 'HEAD dan BODY', 'RUN dan SEND'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag <input type="checkbox"> berfungsi untuk?',
          'options': [
            'Memilih lebih dari satu opsi',
            'Memilih satu opsi saja',
            'Membuat tombol',
            'Membuat text box'
          ],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag <iframe> digunakan untuk?',
          'options': ['Menampilkan halaman lain di dalam halaman', 'Membuat link', 'Membuat animasi', 'Menampilkan video'],
          'correctAnswerIndex': 0,
          'image': 'assets/images/html_iframe_example.png'
        },
        {
          'question': 'Apa fungsi atribut "href" di tag <a>?',
          'options': [
            'Menentukan tujuan link',
            'Menentukan warna link',
            'Menentukan gaya teks',
            'Menentukan ukuran teks'
          ],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag <br> digunakan untuk?',
          'options': ['Baris baru', 'Teks tebal', 'Teks miring', 'Garis horizontal'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag <strong> digunakan untuk?',
          'options': ['Teks tebal', 'Teks miring', 'Teks kecil', 'Teks besar'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Tag <audio> ditambahkan di HTML5 untuk?',
          'options': ['Menampilkan suara', 'Menampilkan video', 'Menampilkan gambar', 'Menampilkan teks'],
          'correctAnswerIndex': 0,
          'image': 'assets/images/html_audio_tag_example.png'
        },
      ],
    },

    'Flutter Quiz': {
      'imagePath': 'assets/images/flutter.png',
      'category': 'Technology',
      'questionCount': 12,
      'questions': [
        {
          'question': 'Siapa yang mengembangkan Flutter?',
          'options': ['Facebook', 'Google', 'Amazon', 'Microsoft'],
          'correctAnswerIndex': 1,
          'image': 'assets/images/flutter.png'
        },
        {
          'question': 'Bahasa utama yang digunakan Flutter?',
          'options': ['Kotlin', 'Swift', 'Dart', 'Python'],
          'correctAnswerIndex': 2
        },
        {
          'question': 'Widget di Flutter digunakan untuk?',
          'options': ['Membuat UI', 'Menyimpan Data', 'Menjalankan Server', 'Mengatur Database'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Widget yang immutable disebut?',
          'options': ['StatelessWidget', 'StatefulWidget', 'InheritedWidget', 'AsyncWidget'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Widget yang memiliki state dinamis disebut?',
          'options': ['StatefulWidget', 'StatelessWidget', 'Container', 'ContextWidget'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Untuk membuat layout vertikal digunakan?',
          'options': ['Column', 'Row', 'Stack', 'GridView'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Untuk membuat layout horizontal digunakan?',
          'options': ['Row', 'Column', 'ListView', 'Stack'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Fungsi dari Scaffold di Flutter adalah?',
          'options': [
            'Struktur dasar halaman',
            'Menampilkan gambar',
            'Menyimpan data',
            'Mengatur database'
          ],
          'correctAnswerIndex': 0,
          'image': 'assets/images/flutter_scaffold_example.png'
        },
        {
          'question': 'Widget untuk tombol dengan desain material?',
          'options': ['ElevatedButton', 'TextButton', 'IconButton', 'OutlinedButton'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Fungsi dari setState() adalah?',
          'options': [
            'Memperbarui UI saat ada perubahan data',
            'Menjalankan ulang aplikasi',
            'Menutup halaman',
            'Menyimpan data ke server'
          ],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Hot reload digunakan untuk?',
          'options': [
            'Mempercepat pengujian UI',
            'Menghapus cache',
            'Menjalankan ulang sistem',
            'Menambah performa CPU'
          ],
          'correctAnswerIndex': 0
        },
        {
          'question': 'File utama Flutter bernama?',
          'options': ['main.dart', 'app.dart', 'index.dart', 'home.dart'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Widget untuk menampilkan teks adalah?',
          'options': ['Text', 'Label', 'Paragraph', 'Typography'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Perhatikan gambar berikut: (gambar) <br> Widget apakah ini?',
          'options': ['Container', 'Card', 'AppBar', 'Scaffold'],
          'correctAnswerIndex': 1,
          'image': 'assets/images/flutter_card_example.png'
        },
        {
          'question': 'Widget untuk membuat area scroll?',
          'options': ['ListView', 'Column', 'Row', 'Stack'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Fungsi MediaQuery.of(context) adalah?',
          'options': [
            'Mendapatkan ukuran layar',
            'Menentukan warna tema',
            'Menangani event klik',
            'Membaca teks input'
          ],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Widget untuk menampilkan gambar dari asset?',
          'options': ['Image.asset', 'Image.network', 'AssetImage', 'Picture.asset'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Untuk navigasi ke halaman lain digunakan?',
          'options': ['Navigator.push', 'Navigator.back', 'Router.go', 'Context.jump'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Widget untuk menampilkan loading indicator?',
          'options': ['CircularProgressIndicator', 'LinearIndicator', 'LoadingBar', 'ProgressWheel'],
          'correctAnswerIndex': 0
        },
        {
          'question': 'Widget GestureDetector digunakan untuk?',
          'options': [
            'Mendeteksi interaksi pengguna seperti tap atau swipe',
            'Menampilkan teks',
            'Menangani layout',
            'Membuat warna latar'
          ],
          'correctAnswerIndex': 0
        },
      ],
    },
  };

  // Akses daftar semua kuis
  static Map<String, Map<String, dynamic>> get allQuizzes => _quizzes;

  // Ambil soal acak sejumlah 'questionCount'
  static List<Question> getRandomQuestions(String quizName) {
    final quiz = _quizzes[quizName]!;
    final count = quiz['questionCount'] as int;
    final questions = List<Map<String, dynamic>>.from(quiz['questions']);

    questions.shuffle(Random());
    return questions.take(count).map((q) => Question.fromJson(q)).toList();
  }
}
