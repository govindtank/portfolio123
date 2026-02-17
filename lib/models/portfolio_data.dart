class Person {
  final String name;
  final String role;
  final String? location;
  final String summary;
  final List<Skill> skills;
  final List<Project> projects;
  final List<Experience> experiences;
  final List<Education> education;
  final Contact contact;

  Person({
    required this.name,
    required this.role,
    this.location,
    required this.summary,
    required this.skills,
    required this.projects,
    required this.experiences,
    required this.education,
    required this.contact,
  });
}

class Skill {
  final String category;
  final List<String> items;

  Skill({required this.category, required this.items});
}

class Project {
  final String name;
  final String description;
  final List<String> technologies;
  final String? link; // Play Store, GitHub, etc.

  Project({
    required this.name,
    required this.description,
    required this.technologies,
    this.link,
  });
}

class Experience {
  final String role;
  final String company;
  final String duration;
  final String? location;
  final String description;

  Experience({
    required this.role,
    required this.company,
    required this.duration,
    this.location,
    required this.description,
  });
}

class Education {
  final String institution;
  final String degree;
  final String duration;
  final String? description;

  Education({
    required this.institution,
    required this.degree,
    required this.duration,
    this.description,
  });
}

class Contact {
  final String? email;
  final String? phone;
  final String? linkedin;
  final String? github;
  final String? website;

  Contact({
    this.email,
    this.phone,
    this.linkedin,
    this.github,
    this.website,
  });
}
