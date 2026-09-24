#import "template.typ": resume

#show: resume.with(
  name: "Igor Bari",
  position: "Senior Frontend Developer",
  photo: "profile.jpg",
  contacts: (
    link("tel:+41798215370")[+41 79 821 53 70],
    link("mailto:mucsi96@gmail.com")[mucsi96\@gmail.com],
    link("https://github.com/mucsi96")[GitHub: mucsi96],
    link("https://www.linkedin.com/in/mucsi")[LinkedIn: mucsi],
  ),
)

#include "summary.typ"
#include "education.typ"
#include "skills.typ"
#include "experience.typ"
#include "open-source.typ"
#include "volunteering.typ"
