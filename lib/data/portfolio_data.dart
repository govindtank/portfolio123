import '../models/portfolio_data.dart';

final Person portfolioData = Person(
  name: 'Govind Tank',
  role: 'Senior Mobile Application Developer (Kotlin | Flutter)',
  location: 'Gandhinagar, Gujarat, India',
  summary:
      'High-performance Senior Mobile Application Developer with 9+ years of experience architecting scalable Android (Kotlin/Java) and Cross-Platform (Flutter) solutions. Proven track record of delivering applications serving 100,000+ active users with 99.9% crash-free stability. Specialized in Clean Architecture, MVVM/Bloc patterns, and modern UI toolkits like Jetpack Compose. Forward-thinking advocate for AI-augmented development, leveraging coding agents like Cursor and Windsurf to accelerate delivery cycles and enhance code quality.',
  skills: [
    Skill(
      category: 'Languages',
      items: [
        'Kotlin',
        'Java',
        'Dart (Flutter)',
        'TypeScript',
        'JavaScript (Node.js)',
        'SQL',
      ],
    ),
    Skill(
      category: 'Android Native',
      items: [
        'SDK',
        'Jetpack Compose',
        'Coroutines',
        'State Flow',
        'LiveData',
        'WorkManager',
        'Android Auto',
        'Material 3',
      ],
    ),
    Skill(
      category: 'Flutter Ecosystem',
      items: [
        'Flutter Bloc',
        'Provider',
        'AutoRoute',
        'Freezed',
        'Method Channels',
        'audio_service',
        'Equatable',
      ],
    ),
    Skill(
      category: 'Architecture',
      items: [
        'Clean Architecture',
        'MVVM',
        'MVI',
        'Repository Pattern',
        'Dependency Injection (Dagger Hilt, Koin)',
      ],
    ),
    Skill(
      category: 'Backend & Cloud',
      items: [
        'Node.js',
        'Express.js',
        'Firebase (Auth, Firestore, FCM)',
        'AWS CloudFront',
        'RESTful APIs',
        'GraphQL',
      ],
    ),
    Skill(
      category: 'AI & Next-Gen Dev',
      items: [
        'Cursor',
        'Windsurf',
        'Claude Code',
        'OpenRouter API',
        'Anti Gravity',
        'Kilo Code',
        'Open Claw',
      ],
    ),
    Skill(
      category: 'DevOps & Tools',
      items: [
        'CI/CD (GitHub Actions)',
        'Docker',
        'Git',
        'Gradle',
        'Android Studio',
        'Postman',
        'Play Store Console',
      ],
    ),
  ],
  projects: [
    Project(
      name: 'BAPS Prakash',
      description:
          'Directed the complete overhaul of the "BAPS Prakash" application (50k+ users). Engineered a secure audio streaming engine using AWS CloudFront Signed Cookies, successfully preventing unauthorized access to copyright-protected content.\n\n• Implemented AWS CloudFront Signed Cookies for copyright protection\n• Integrated audio_service for seamless background playback and Android Auto\n• Achieved 99.9% crash-free stability',
      technologies: ['Flutter', 'AWS CloudFront', 'audio_service', 'Android Auto'],
      link: 'https://play.google.com/store/apps/details?id=org.baps.swaminarayanprakash',
    ),
    Project(
      name: 'Akshar Amrutam',
      description:
          'Spearheaded the development of "Akshar Amrutam," scaling it to 100,000+ downloads. Enforced strict separation of UI, Domain, and Data layers, resulting in a 99.95% crash-free session rate.\n\n• Scaled to 100,000+ downloads with 99.95% crash-free rate\n• Utilized Flutter Bloc for complex state management\n• Managed end-to-end project delivery for international markets',
      technologies: ['Flutter', 'Clean Architecture', 'Bloc', 'MVVM'],
      link: 'https://play.google.com/store/apps/details?id=org.baps.akshar_amrutam',
    ),
    Project(
      name: 'Smartindia/Autozon',
      description:
          'Built the "Smartindia/Autozon" application, implementing real-time MQTT communication between mobile devices and IoT hardware. Optimized battery usage for companion apps by refactoring background services.\n\n• Implemented real-time MQTT communication for IoT\n• Optimized battery usage via background services\n• Integrated voice assistants (Alexa, Google Assistant)',
      technologies: ['Android', 'MQTT', 'IoT', 'BLE', 'Voice Assistants'],
      link: 'https://play.google.com/store/apps/details?id=com.voiceofthings.smartindia',
    ),
    Project(
      name: 'La Crosse View',
      description:
          'Engineered robust background services for "La Crosse View," ensuring reliable data synchronization with weather station hardware.\n\n• Reduced application startup time by 30%\n• Reduced memory footprint by 20%\n• Ensured reliable hardware synchronization',
      technologies: ['Android', 'Background Services', 'Kotlin'],
      link: 'https://play.google.com/store/apps/details?id=com.lacrosseview.app',
    ),
    Project(
      name: "Max's Fun Club",
      description:
          "Managed end-to-end delivery of international projects (DRC USA, Max's Fun Club South Africa), ensuring strict adherence to timelines and quality standards.\n\n• Coordinated global teams for South African deployment\n• Ensured engaging user experiences for kids\n• Handled cross-cultural adaptations",
      technologies: ['Flutter', 'International Delivery', 'Localization'],
      link: 'https://play.google.com/store/apps/details?id=com.maxfunclub',
    ),
    Project(
      name: 'HCP ERP System',
      description:
          'Architected high-concurrency RESTful APIs using Node.js and TypeScript for an internal HCP ERP system, optimizing complex resource allocation logic for enterprise use.\n\n• Designed for high-concurrency scenarios\n• Optimized complex resource allocation logic\n• Enterprise-level performance optimization',
      technologies: ['Node.js', 'TypeScript', 'REST APIs', 'Express.js'],
      link: null,
    ),
  ],
  experiences: [
    Experience(
      role: 'Senior Software Developer L2',
      company: 'Rysun Labs Pvt. Ltd.',
      duration: 'Nov 2025 -- Present',
      location: 'Ahmedabad, India',
      description:
          '• Directed complete overhaul of "BAPS Prakash" app (50k+ users) with secure AWS CloudFront audio streaming\n• Integrated audio_service for background tasks, lock-screen controls, and Android Auto compatibility\n• Architected high-concurrency RESTful APIs using Node.js and TypeScript for HCP ERP system',
    ),
    Experience(
      role: 'Senior Software Developer / Project Owner',
      company: 'Rysun Labs Pvt. Ltd.',
      duration: 'Apr 2022 -- Oct 2024',
      location: 'Ahmedabad, India',
      description:
          '• Spearheaded "Akshar Amrutam" development, scaling to 100,000+ downloads with 99.95% crash-free rate\n• Utilized Flutter Bloc for complex state management ensuring 60fps performance\n• Built "Smartindia/Autozon" IoT app with real-time MQTT communication\n• Managed end-to-end delivery of international projects (DRC USA, Max\'s Fun Club South Africa)',
    ),
    Experience(
      role: 'Software Engineer - Android',
      company: 'Phycom Corporations',
      duration: 'Apr 2021 -- Mar 2022',
      location: 'Ahmedabad, India',
      description:
          '• Engineered robust background services for "La Crosse View" weather app\n• Reduced application startup time by 30% and memory footprint by 20%\n• Refactored legacy Java codebases to Kotlin, reducing NullPointerExceptions by 95%',
    ),
    Experience(
      role: 'Remote Android Developer',
      company: 'Micro App Solutions',
      duration: 'Aug 2017 -- Dec 2019',
      location: 'Surat, India',
      description:
          '• Developed "Fastrrr-Floating Apps" and "Water Reminder" with complex overlay window permissions\n• Built "OfferzZone" hyper-local marketplace utilizing Geofencing APIs\n• Maintained strict battery efficiency protocols',
    ),
    Experience(
      role: 'Android Developer',
      company: 'Stimulus Consultancy',
      duration: 'Apr 2016 -- Aug 2017',
      location: 'Ahmedabad, India',
      description:
          '• Established initial CI/CD pipelines and repository structures for "City Tadka" and "Oowomaniya"\n• Implemented complex tax calculation logic for GST application with 100% accuracy\n• Reduced deployment friction in early-stage development',
    ),
  ],
  education: [
    Education(
      institution: 'AES College',
      degree: 'Master of Computer Applications (M.C.A.)',
      duration: '2013 -- 2015',
      description: 'Advanced studies in computer science and application development',
    ),
    Education(
      institution: 'Navgujarat College',
      degree: 'Bachelor of Computer Applications (B.C.A.)',
      duration: '2010 -- 2013',
      description: 'Focused on software development and programming fundamentals',
    ),
  ],
  contact: Contact(
    email: 'govindtank600@gmail.com',
    phone: '+91 84604848061',
    linkedin: 'https://linkedin.com/in/govindtank',
    github: 'https://github.com/govindtank',
    website: 'https://x.com/govindtank4',
  ),
);
