# Eksamen PGR301 2023

## Secrets og Variables som trengs for at Github Actions skal kjøre som forventet.
### AWS (environment secrets)
- AWS_ACCESS_KEY_ID 
- AWS_SECRET_ACCESS_KEY
* Begge disse to får man ved å gå inn i "IAM" -> "My security credentials" -> under "Access Keys" trykk "create new access key" -> velg "Other" -> lag en description -> ta vare på keysene som blir vist, det burde være mulig å laste de ned.
* Kan også bruke denne linken for å komme seg til Key Wizard: https://us-east-1.console.aws.amazon.com/iam/home?region=eu-north-1#/security_credentials/access-key-wizard

### Kjell's python kode (environment variables)
- DEPLOY_BUCKET_NAME = Dette er hvilken Bucket SAM skal deploye til (f.eks "candidate2004")
- DEPLOY_STACK_NAME  = Hva stacken SAM lager skal kalles (f.eks "candidate2004")
- IMAGE_BUCKET_NAME  = Navnet til bucketen med bildene som skal analyseres (f.eks "kjellsimagebucket" eller "candidate2004-image-bucket")

### Terraform / Java (environment variables)
-  ECR_REPO          = Linken til ECR repo der Docker Imagen skal bli lastet opp (f.eks "244530008913.dkr.ecr.eu-west-1.amazonaws.com/2004-ecr-repo")


## Begrunnelser og bevsarelser:
### Oppgave 4. Feedback
![bilde](https://github.com/Mebu98/eksamen_2023_kn2004/assets/89260657/47d6f960-3158-4813-95b0-8a1fa86ccfdb)

#### A. Utvid applikasjonen og legg inn "Måleinstrumenter"
Jeg la til måleinstrumenter som måler antall bilder scannet, antall personer sett, antall personer uten maske, og antall personer uten hjelm. 
Videre har jeg lagt til timers for hvor lang tid det tok å analysere hvert bilde, men de har jeg ikke fått lagt til ennå. 

#### B. CloudWatch Alarm og Terraform moduler
Jeg har lagt til en alarm som går av hvis anntall personer uten hjelm stiger over 25%, dette kan muligens være nyttig på f.eks en byggeplass der alle burde gå med hjelm. 
Grunnen til at jeg valgte 25% som grensen er fordig det er mulig at folk som ikke er på byggeplassen kan evt bli sett på bilde, videre er det jo mulig at den feil-registrer hvis hode til en person er gjemt (har ikke eksperimentert så mye...)

### Oppgave 5. Drøfteoppgaver
### A. Kontinuerlig Integrering
CI er en programmeringsmetodikk som innebærer at å sammenslå kodeendringer fra flere utviklere i et felles område ofte og automatisk. En vanlig utviklingsprosess innebærer ofte et par steg; utvikling -> bygging -> testing -> lansering -> analysering av bruk -> planlegging -> og så tilbake til utvikling. CI gjør det dermed mulig å automatisere store deler av bygging, testing, og lanseringen, som fort kan kreve mye repetisjon og skriving. 
Fordeler med CI:
-	Reduserer sjansen til store merge-conflicts og integrasjonsfeil ved å holde kodebasen som blir jobbet på i team oppdatert.
-	Rask tilbakemelding på kvalitet og funksjonaliteten til koden gjennom automatisert validering og testing.
-	Gjør det lettere å jobbe sammen i team når man har litt ide av hva andre holder på med.

Ulemper med CI:
-	Krever trening for å bli kjent med CI verktøy og arbeidsmetodikk.
-	Krever servere hvor bygging og testing kan bli utført, dette kan øke kompleksiteten og kostnadene til infrastrukturen.
-	Krever hyppig sammenslåing, siden hvis man ender opp for langt bak main branch kan det lede til store merge-conflicts og bugs.
	
Eksempel på praktisk arbeid med CI:
1.	Du jobber i et team med 5 andre, hvor hver av dere holder på med ditt i en egen lokal branch av main.
2.	Når du er ferdig med det du holder på med laster du opp den lokale branch’en din og sender inn en pull-request til main.
3.	pull-request’en trigger en automatisert workflow fil, som f.eks github actions som bygger og tester prosjektet etter du har lastet det opp sånn at alt ‘’funker’’ som det skal. Hvis den mislykkes noe sted, sender den en melding til deg / teamet.
4.	Andre utviklere på teamet ditt ser over hva du har gjort og resultatene til workflows’ene.
5.	Hvis de andre syntes det ser bra ut og det passerer alle testene, så blir den sendt videre til main branch
6.	Main branch kjører sin egen workflow for å dobbelt sjekke at alt funker i main.
7.	Hvis main sin workflow er satt opp for det, så er det også mulig at lanseringen blir automatisert.

### B. Sammenligning av Scrum/Smidig og DevOps fra et Utviklers Perspektiv
#### Scrum / Smidig metodikk
Scrum er en metodikk som brukes til å utvikle, levere, og vedlikeholde komplekse produkter. Det er basert på erfaringsfilosofi, der kunnskap kommer fra erfaring og beslutninger tas ut ifra det som er kjent. Scrum har tre hoved pilarer; åpenhet, introspeksjon, og tilpasning. 

Scrum består av tre roller:
1.	Produkteieren er ansvarlig for å representere kunden og prioritere oppgavene som skal utføres. De har som oftest ansvar for å lage og vedlikeholde «product backlog», som er en liste av krav som skal inngå i produktet.
2.	Utviklingsteamet har ansvar for å bygge et produkt i henhold til produkteierens prioritering. De er ofte selvorganiserende, tverrfaglig, og samarbeidsorientert.
3.	Scrum lederen er ansvarlig for godt samarbeid og støtte i løpet prosessen. De hjelper produkteieren, utviklingsteamet, og organisasjonen med å forstå og følge scrum rammeverket.

I scrum jobber man ofte i «sprints» som ofte er et par uker. I løpet av en sprint har man et par faste hendelser: 
-	Sprintplanlegging er et møte der produkteieren og utviklingsteamet blir enige om hva som skal gjøres i den kommende sprinten. Møtet består av to deler: den første delen handler om å velge hvilke elementer fra produktkøen som skal inngå i sprinten, og den andre delen handler om å lage en plan for hvordan disse elementene skal iverksettes.
-	Daglig scrum er et kort møte hver dag der utviklingsteamet deler status, fremdrift, og utfordringer med hverandre. Møtet varer ofte ikke lengre enn 15 minutter og har tre spørsmål: hva har jeg gjort siden forrige møte, hva skal jeg gjøre før neste møte, og hva hindrer meg i å gjøre mitt arbeid.
-	Sprintgjennomgang er et møte mot slutten av sprinten der utviklingsteamet presenterer produktinkrementet som er laget i sprinten for produkteieren. Møtet har som formål å samle tilbakemeldinger, evaluere resultatet og justere produktkøen.
-	Sprintevaluering med burndown-diagram er et møte der utviklingsteamet og scrum lederen reflekterer over sprinten som har gått og identifiserer muligheter for forbedring. Møtet har som formål å øke kvaliteten, effektiviteten og tilfredsheten i teamet.

Ulemper med scrum:
-	Scrum krever en arbeidskultur av åpenhet og tillit, hvor man kan be om assistanse hvis man møter på noe man ikke har kunnskap til og kan akseptere feil.
-	Krever at produkteier har en klar visjon for produktet. Hvis produkteieren ikke har nokk kunnskap eller autoritet kan det føre til misforståelser og konflikter mellom dem og utviklingsteamet.
-	Scrum lederen har en viktig rolle i å fasilitere og støtte prosessen, men ikke en tradisjonell prosjektlederrolle. Scrum lederen skal ikke gi instruksjoner, delegere oppgaver eller kontrollere teamet, men heller hjelpe teamet med å fjerne hindringer, løse konflikter og forbedre seg. Dette kan være utfordrende for Scrum ledere som har vanskelig for å gi slipp på autoritet eller ansvar, eller for noen team som forventer mer ledelse eller veiledning.


#### DevOps
DevOps er en metodikk som har som mål å automatisere så mye som mulig av utviklingssyklusen. Noen av de grunnleggene prinsippene til DevOps er:
-	Samarbeid, utviklings- og driftsteam skal jobbe sammen, dele, og gi tilbakemelding til hverandre gjennom hele prossesen.
-	Automatisering, ett av de viktigste elementene av DevOps er å automatisere så mye som mulig av utviklingssyklusen. Dette gir mer tid til utviklere, slik at de kan skrive mer kode og utvikle funksjoner fortere. Det bidrar også til reduksjon av menneskelige feil.
-	
Fordeler med DevOps:
-	Ved å bruke automatiserte tester, CI, og CD kan teamene oppdage og rette feil raskere.
-	Med bruken av smidige metodikker kan teamene levere programvaren raskere og oftere, dette kan gi dem et konkurransefortrinn i markedet.
-	Automatisering av så mye som mulig reduserer mye manuelt arbeid, menneskelige feil, og sløsing.

Ulemper med DevOps:
-	DevOps kan kreve at alle teammedlemmene har et bredt spektrum av ferdigheter og kunnskap til forskjellig verktøy.
-	DevOps kan innebære bruken av mange verktøy og tjenester, noe som kan påvirke kompleksiteten, skalerbarheten, og fleksibiliteten. 
-	Hvis det er mange verktøy, prosesser, og tjenester som blir tatt i bruk i automatiseringen kan det fort bli problemer hvis det viser seg å være ett problem med en av dem.

#### Sammenlign og kontrast

Scrum er et rammeverk av roller, regler, og hendelser. Det består av iterasjoner kalt sprinter, som vanligvis varer fra en til fire uker, og sikrer dermed regelmessig levering av nye produkt versjoner. DevOps derimot er en samling av teknologier, ideer, og prosesser som brukes av både utviklings og driftsteam for å forbedre utviklingsprosessen. Begge metodologiene vektlegger effektiv kommunikasjon mellom de forskjellige partiene i gruppen.
Scrum bruker ulike artefakter som; produktloggen, sprintloggen, og burndown-grafen for å planlegge, utføre, og evaluere arbeidet. DevOps derimot fokuserer på automatisering og optimalisering av utviklingsprosessen. 
Scrum er en metodikk som kan brukes for å utvikle nesten alle typer prosjekter, og er egnet for de som krever regelmessige endringer, tilbakemeldinger, og forbedringer. Scrum er også godt egnet for prosjekter som har team med tverrfaglig erfaring og kan jobbe selvstendig og kreativt. DevOps er en kultur som vil nesten påvirke hele organisasjonen, og påvirker alle aspekter av utviklingsprosessen. DevOps er kritisk for prosjekter som krever hyppig utgivelser og ikke har råd til lang ventetid mellom utvikling og drift.

Til slutt er Scrum og DevOps ikke motstridene metodikker, en kjent organisasjon som bruker begge metodikkene sammen er Microsoft!


### C. Det Andre Prinsippet - Feedback

TODO

## Checklist:
### Oppgave 1 - Kjell's python code

#### A. SAM & GitHub actions workflow
- [x]  Fjerne hardkoding  av S3 bucket navnet ```app.py koden```, slik at den leser verdien "BUCKET_NAME" fra en miljøvariabel.
- [x]  Du skal opprette en GitHub Actions-arbeidsflyt for SAM applikasjonen. For hver push til main branch, skal
  arbeidsflyten bygge og deploye Lambda-funksjonen.
- [x] Som respons på en push til en annen branch en main, skal applikasjonen kun bygges.
- [x] Sensor vil lage en fork av ditt repository. Forklar hva sensor må gjøre for å få GitHub Actions workflow til å kjøre i
  sin egen GitHub-konto.

#### B. Docker container
- [x] Lag en Dockerfile som bygger et container image du kan bruke for å kjøre python koden.
- [x] Dockerfilen skal lages i mappen ```/kjell/hello_world```.
- [x] Sensor skal kunne gjøre følgende kommando for å bygge et
container image og kjøre koden.
```shell
docker build -t kjellpy . 
docker run -e AWS_ACCESS_KEY_ID=XXX -e AWS_SECRET_ACCESS_KEY=YYY -e BUCKET_NAME=kjellsimagebucket kjellpy
```

### Oppgave 2. Overgang til Java og Spring boot

#### A. Dockerfile
- [x] Test java-applikasjonen lokalt i ditt cloud9 miljø ved å stå i rotmappen til ditt repository, og kjøre kommandoen mvn spring-boot:run
- [x] Du kan teste applikasjonen i en terminal med curl localhost:8080/scan-ppe?bucketName=<din bucket> og se på responsen.
- [x] Lag en Dockerfile for Java-appliksjonen. Du skal lage en multi stage Dockerfile som både kompilerer og kjører applikasjonen.
- [x] Sensor vil lage en fork av ditt repository, og skal kunne kjøre følgende kommandoer for å starte en docker container
```shell
docker build -t ppe . 
docker run -p 8080:8080 -e AWS_ACCESS_KEY_ID=XXX -e AWS_SECRET_ACCESS_KEY=YYY -e BUCKET_NAME=kjellsimagebucket ppe
```

#### B. GitHub Actions workflow for container image og ECR
- [x] Du skal nå automatisere prosessen med å bygge/kompilere og teste Java-applikasjonen. Lag en ny GitHub Actions Workflow fil, ikke gjenbruk den du lagde for Pythonkoden.
- [x] Lag en GitHub actions workflow som ved hver push til main branch lager og publiserer et nytt Container image til et ECR repository.
- [x] Workflow skal kompilere og bygge et nytt container image, men ikke publisere image til ECR dersom branch er noe annet en main.
- [x] Du må selv lage et ECR repository i AWS miljøet, du trenger ikke automatisere prosessen med å lage dette.
- [x] Container image skal ha en tag som er lik commit-hash i Git, for eksempel: glenn-ppe:b2572585e.
- [x] Den siste versjonen av container image som blir pushet til ECR, skal i tillegg få en tag "latest".

### Oppgave 3 - Terraform, AWS Apprunner og Infrastruktur som kode
Se på koden som ligger i infra katalogen, den inneholder kun en app_runner_service og en IAM roller som gjør denne i stand til å gjøre API kall mot AWS Rekognition og lese fra S3.

#### A. Kodeendringer og forbedringer
- [x] Fjern hardkodingen av service_name, slik at du kan bruke ditt kandidatnummer eller noe annet som service navn.
- [x] Se etter andre hard-kodede verdier og se om du kan forbedre kodekvaliteten.
- - uhhhh, har glemt litt å se så hardt på dette, men har gjort mitt beste...
- [x] Se på dokumentasjonen til aws_apprunner_service ressursen, og reduser CPU til 256, og Memory til 1024 (defaultverdiene er høyere)

#### B. Terraform i GitHub Actions
- [x] Utvid din GitHub Actions workflow som lager et Docker image, til også å kjøre terraformkoden
- [x] På hver push til main, skal Terraformkoden kjøres etter jobber som bygger Docker container image
- [x] Du må lege til Terraform provider og backend-konfigurasjon. Dette har Kjell glemt. Du kan bruke samme S3 bucket som vi har brukt til det formålet i øvingene.
- [x] Beskriv også hvilke endringer, om noen, sensor må gjøre i sin fork, GitHub Actions workflow eller kode for å få denne til å kjøre i sin fork.

### Oppgave 4. Feedback

#### A. Utvid applikasjonen og legg inn "Måleinstrumenter"
I denne oppgaven får dere stor kreativ frihet i å utforske tjenesten Rekognition. Derw skal lage ny og relevant funksjonalitet. Lag minst et nytt endepunkt, og utvid gjerne også den eksisterende koden med mer funksjonalitet. Se på dokumentasjonen; https://aws.amazon.com/rekognition/
- [x] Nå som dere har en litt større kodebase. Gjør nødvendige endringer i Java-applikasjonen til å bruke Micrometer rammeverket for Metrics, og konfigurer for leveranse av Metrics til CloudWatch
- [x] Dere kan detetter selv velge hvordan dere implementerer måleinstrumenter i koden.
- [x] Dere skal skrive en kort begrunnelse for hvorfor dere har valgt måleinstrumentene dere har gjort, og valgene må være relevante. Eksempelvis vil en en teller som øker hver gang en metode blir kalt ikke bli vurdert som en god besvarelse, dette fordi denne metrikkene allerede leveres av Spring Boot/Actuator.

#### B. CloudWatch Alarm og Terraform moduler
- [x] Lag en CloudWatch-alarm som sender et varsel på Epost dersom den utløses.Dere velger selv kriteriet for kriterier til at alarmen skal løses ut, men dere må skrive en kort redgjørelse for valget.
- [x] Alarmen skal lages ved hjelp av Terraformkode. Koden skal lages som en separat Terraform modul. Legg vekt på å unngå hardkoding av verdier i modulen for maksimal gjenbrukbarhet. Pass samtidig på at brukere av modulen ikke må sette mange variabler når de inkluderer den i koden sin.
## Krav til leveransen

* Eksamensoppgaven, kode og nødvendig filer er tilgjengelig i GitHub-repo: https://github.com/glennbechdevops/eksamen_2023.
* Når du leverer inn oppgaven via WiseFlow, vennligst opprett et tekstdokument som kun inneholder en kobling til ditt
  repository.
* Vennligst bruk et tekstdokumentformat, ikke PDF, Word eller PowerPoint.
* Du skal ikke opprette en fork av dette repositoryet, men heller kopiere innholdet til et nytt repository.
* Hvis du er bekymret for plagiat fra medstudenter, kan du arbeide i et privat repository og deretter gjøre det
  offentlig tilgjengelig like før innleveringsfristen.

Når sensoren evaluerer oppgaven, vil han/hun:

* Sjekke ditt repository og gå til fanen "Actions" på GitHub for å bekrefte at Workflows faktisk fungerer som de skal.
* Vurdere drøftelsesoppgavene. Du må opprette en "Readme" for besvarelsen i ditt repository. Denne "Readme"-filen skal
  inneholde en grundig beskrivelse og drøfting av oppgavene.
* Sensoren vil opprette en "fork" (en kopi) av ditt repository og deretter kjøre GitHub Actions Workflows med sin egen
  AWS- og GitHub-bruker for å bekrefte at alt fungerer som forventet.

## Om GitHub Free Tier

- I oppgaven blir du bedt om å opprette GitHub Actions Workflows.
- Med GitHub Free Tier har du 2000 minutter med gratis byggetid per måned i private repository.
- Hvis du trenger mer byggetid, har du alternativet å gjøre repositoryet offentlig. Dette vil gi
  deg ubegrenset byggetid. GitHub gir ubegrenset byggetid for offentlige repoer.
- Hvis du er bekymret for at andre kan kopiere arbeidet ditt når repositoryet er offentlig, kan du opprette en ny
  GitHub-bruker med et tilfeldig navn for anonymitet.

## Spesielle hensyn knyttet til Cloud 9

- Løsning på problem med diskplassmangel - informasjon blir delt på Canvas-plattformen.
- Informasjon om rettigheter og sikkerhet i Cloud 9 vil også bli delt på Canvas.

# Evaluering

- Oppgave 1. Kjells Pythonkode - 20 Poeng
- Oppgave 2. Overgang til Java og Spring Boot - 15 Poeng
- Oppgave 3. Terraform, AWS Apprunner og IAC - 15 Poeng
- Oppgave 4. Feedback -30 Poeng
- Oppgave 5. Drøfteoppgaver - 20 poeng

# Oppgavebeskrivelse

I et pulserende teknologisamfunn på Grünerløkka, Oslo, har en livlig oppstart ved navn 'VerneVokterne' funnet
sitt eget nisjeområde innenfor helsesektoren. De utvikler banebrytende programvare for bildebehandling som er
designet
for å sikre at helsepersonell alltid bruker personlig verneutstyr (PPE). Med en lidenskap for innovasjon og et sterkt
ønske om å forbedre arbeidssikkerheten, har 'VerneVokterne' samlet et team av dyktige utviklere, engasjerte designere og
visjonære produktledere.

Selskapet hadde tidligere en veldig sentral utvikler som heter Kjell. Kjell hadde en unik tilnærming til kode,
Dessverre var kvaliteten på Kjells kode, for å si det pent, "kreativ."

Som nyansatt har du blitt gitt den utfordrende oppgaven å overta etter "Kjell," som ikke lenger er en del av selskapet.

![Logo](img/logo.png "Assignment logo")

# Litt om AWS Rekognition

I denne oppgaven skal dere bli kjent med en ny AWS tjeneste.

AWS Rekognition er en tjeneste fra Amazon Web Services som tilbyr avansert bilde- og videoanalyse ved hjelp av
maskinlæringsteknologi. Den har en rekke funksjoner for å gjenkjenne og analysere ulike elementer i bilder og videoer,
inkludert ansiktsgjenkjenning, objektgjenkjenning, tekstgjenkjenning og mer.

AWS Rekognition kan brukes til å identifisere om personer på bilder eller i videoer bruker riktig personlig
beskyttelsesutstyr som hjelmer, vernebriller,
hansker og verneklær. Dette kan være spesielt nyttig i situasjoner der det er viktig å sikre at arbeidere eller
besøkende følger sikkerhetskravene, for eksempel i byggebransjen, industrielle anlegg eller helsevesenet.

Tjenesten kan også tilpasse seg ulike bransjer og bruksområder ved å tillate brukerne å lage
egendefinerte modeller basert på sine egne datasett og krav.

For å bruke AWS Rekognition for PPE-deteksjon, laster du enkelt opp bilder eller videoer til tjenesten, og den vil
deretter analysere innholdet og gi deg informasjon om hvorvidt PPE er tilstede og eventuelt gi posisjonsdata for hvor
PPE er funnet.

Bruk gjerne litt tid til å bli kjent med tjenesten i AWS
miljøet https://eu-west-1.console.aws.amazon.com/rekognition/home

# Oppgave 1. Kjell's Python kode

## A. SAM & GitHub actions workflow

Koden er skrevet som en AWS SAM applikasjon, og ligger i mappen "kjell" i dette repoet. Det er åpenbart at Kjell har
tatt utgangspunkt i et "Hello World" SAM prosjekt og bare brukt navnet sitt som applikasjonsnavn.

* Denne SAM-applikasjonen oppretter en S3 Bucket og du bør sørge for at den lages med ditt kandidatnavn, og du kan under eksamen bruke
  denne bucketen til å laste opp egne bilder for å teste din egen applikasjon.
* I ditt Cloud9-miljø, eller på din egen maskin, kan du bygge og deploye koden til AWS ved å bruke ```sam cli```
* Det anbefales å teste dette før du fortsetter.

Advarsel! Se opp for hardkoding ! Du må kanskje endre noe for å få deployet selv.

### Oppgave

* Fjerne hardkoding  av S3 bucket navnet ```app.py koden```, slik at den leser verdien "BUCKET_NAME" fra en miljøvariabel.
* Du kan gjerne teste APIet ditt ved å bruke kjell sine bilder  https://s3.console.aws.amazon.com/s3/buckets/kjellsimagebucket?region=eu-west-1
* Du skal opprette en GitHub Actions-arbeidsflyt for SAM applikasjonen. For hver push til main branch, skal
  arbeidsflyten bygge og deploye Lambda-funksjonen.
* Som respons på en push til en annen branch en main, skal applikasjonen kun bygges.
* Sensor vil lage en fork av ditt repository. Forklar hva sensor må gjøre for å få GitHub Actions workflow til å kjøre i
  sin egen GitHub-konto.

## B. Docker container

Python er ikke et veldig etablert språk i VerneVokterene, og du vil gjerne at utviklere som ikke har Python
installert på sin maskin skal kunne teste koden.

### Opppgave

Lag en Dockerfile som bygger et container image du kan bruke for å kjøre python koden.

Dockerfilen skal lages i mappen ```/kjell/hello_world```. Sensor skal kunne gjøre følgende kommando for å bygge et
container image og kjøre koden.

```shell
docker build -t kjellpy . 
docker run -e AWS_ACCESS_KEY_ID=XXX -e AWS_SECRET_ACCESS_KEY=YYY -e BUCKET_NAME=kjellsimagebucket kjellpy
```

Det ligger noen hint i filen app.py som vil hjelpe deg med å lage en ```Dockerfile```.

# Oppgave 2. Overgang til Java og Spring boot

Du innser raskt at Python ikke er veien videre for et konkurransedyktig produkt og har selv laget starten på en
Java-applikasjon som ligger i dette repoet. Applikasjonen er en Spring Boot applikasjon, som eksponerer et endepunkt

```http://<host>:<port>/scan-ppe?bucketName=<bucketnavn>```

Som du vil se bearbeider java-koden response fra tjenesten Rekognition litt mer en hva Python-varianten gjør.
En respons fra Java-applikasjonen kan se slik ut

```shell
{
    "bucketName": "kjellsimagebucket",
    "results": [
        {
            "fileName": "Man-in-PPE-kit-307511-pixahive.jpg",
            "violation": false,
            "personCount": 1
        },
        {
            "fileName": "almost_ppe.jpeg",
            "violation": false,
            "personCount": 1
        },
        {
            "fileName": "download.jpeg",
            "violation": true,
            "personCount": 1
        },
        {
            "fileName": "one_person_ppe.jpeg",
            "violation": false,
            "personCount": 1
        },
        {
            "fileName": "personnel-with-the-united-states-public-health-service-34a5d6-1024.jpg",
            "violation": false,
            "personCount": 2
        },
        {
            "fileName": "two_persons_one_no_ppe.jpeg",
            "violation": true,
            "personCount": 2
        }
    ]
}
```

Vi får tilbake ett JSON-objekt per fil i S3 Bucketen som inneholder følgende attributter

* Filename - Navnet på filen i S3 bucketen
* violation - true hvis det er person, eller personer på bildet uten nødvendig utstyr
* personCount - hvor mange personer Rekognition fant på bildet.

## A. Dockerfile

* Test java-applikasjonen lokalt i ditt cloud9 miljø ved å stå i rotmappen til ditt repository, og kjøre
  kommandoen ```mvn spring-boot:run```
* Du kan teste applikasjonen i en terminal med ```curl localhost:8080/scan-ppe?bucketName=<din bucket>``` og se på
  responsen.

### Oppgave

* Lag en Dockerfile for Java-appliksjonen. Du skal lage en multi stage Dockerfile som både kompilerer og kjører
  applikasjonen.

Sensor vil lage en fork av ditt repository, og skal kunne kjøre følgende kommandoer for å starte en docker container

```shell
docker build -t ppe . 
docker run -p 8080:8080 -e AWS_ACCESS_KEY_ID=XXX -e AWS_SECRET_ACCESS_KEY=YYY -e BUCKET_NAME=kjellsimagebucket ppe
```

## B. GitHub Actions workflow for container image og ECR

Du skal nå automatisere prosessen med å bygge/kompilere og teste Java-applikasjonen.
Lag en ny GitHub Actions Workflow fil, ikke gjenbruk den du lagde for Pythonkoden.

### Oppgave

* Lag en GitHub actions workflow som ved hver push til main branch lager og publiserer et nytt Container image til et
  ECR repository.
* Workflow skal kompilere og bygge et nytt container image, men ikke publisere image til ECR dersom branch er noe annet en main.
* Du må selv lage et ECR repository i AWS miljøet, du trenger ikke automatisere prosessen med å lage
  dette.
* Container image skal ha en tag som er lik commit-hash i Git, for eksempel: ```glenn-ppe:b2572585e```.
* Den siste versjonen av container image som blir pushet til ECR, skal i tillegg få en tag "latest".

# Oppgave 3- Terraform, AWS Apprunner og Infrastruktur som kode

Se på koden som ligger i infra katalogen, den inneholder kun en app_runner_service og en IAM roller som gjør denne i
stand til å gjøre API kall mot AWS Rekognition og lese fra S3.

## A. Kodeendringer og forbedringer

* Fjern hardkodingen av service_name, slik at du kan bruke ditt kandidatnummer eller noe annet som service navn.
* Se etter andre hard-kodede verdier og se om du kan forbedre kodekvaliteten.
* Se på dokumentasjonen til aws_apprunner_service ressursen, og reduser CPU til 256, og Memory til 1024 (defaultverdiene
  er høyere)

## B. Terraform i GitHub Actions

* Utvid din GitHub Actions workflow som lager et Docker image, til også å kjøre terraformkoden
* På hver push til main, skal Terraformkoden kjøres etter jobber som bygger Docker container image
* Du må lege til Terraform provider og backend-konfigurasjon. Dette har Kjell glemt. Du kan bruke samme S3 bucket
  som vi har brukt til det formålet i øvingene.
* Beskriv også hvilke endringer, om noen, sensor må gjøre i sin fork, GitHub Actions workflow eller kode for å få denne til å kjøre i sin fork.

# Oppgave 4. Feedback

## A. Utvid applikasjonen og legg inn "Måleinstrumenter"

I denne oppgaven får dere stor kreativ frihet i å utforske tjenesten Rekognition. Derw skal lage ny og relevant funksjonalitet.
Lag minst et nytt endepunkt, og utvid gjerne også den eksisterende koden med mer funksjonalitet.
Se på dokumentasjonen; https://aws.amazon.com/rekognition/

### Oppgave

* Nå som dere har en litt større kodebase. Gjør nødvendige endringer i Java-applikasjonen til å bruke Micrometer
  rammeverket for Metrics, og konfigurer  for leveranse av Metrics til CloudWatch
* Dere kan detetter selv velge hvordan dere implementerer måleinstrumenter i koden.

Med måleinstrumenter menes i denne sammenhengen ulike typer "meters" i micrometer rammeverket for eksempel;

* Meter
* Gauge
* Timer
* LongTaskTimer
* DistributionSummary

Dere skal skrive en kort begrunnelse for hvorfor dere har valgt måleinstrumentene dere har gjort, og valgene må  være relevante.
Eksempelvis vil en en teller som øker hver gang en metode blir kalt ikke bli vurdert som en god besvarelse, dette fordi denne
metrikkene allerede leveres av Spring Boot/Actuator.

### Vurderingskriterier

* Hensikten med å utvide kodebasen er å få flere naturlige steder å legge inn måleinstrumenter. Det gis ikke poeng for et stort kodevolum, men en god besvarelse vil legge til virkelig og nyttig funksjonalitet.
* En god besvarelse registrer både tekniske, og foretningsmessig metrikker.
* En god besvarelse bør bruke minst tre ulike måleinstrumenter på en god og relevant måte.

### B. CloudWatch Alarm og Terraform moduler

Lag en CloudWatch-alarm som sender et varsel på Epost dersom den utløses.Dere velger selv kriteriet for kriterier til at alarmen
skal løses ut, men dere  må skrive en kort redgjørelse for valget.

Alarmen skal lages ved hjelp av Terraformkode. Koden skal lages som en separat Terraform modul. Legg vekt på å unngå
hardkoding  av verdier i modulen for maksimal gjenbrukbarhet. Pass samtidig på at brukere av modulen ikke må sette mange
variabler når de inkluderer den i koden sin.

# Oppgave 4. Drøfteoppgaver

## Det Første Prinsippet - Flyt

### A. Kontinuerlig Integrering

Forklar hva kontinuerlig integrasjon (CI) er og diskuter dens betydning i utviklingsprosessen. I ditt svar,
vennligst inkluder:

- En definisjon av kontinuerlig integrasjon.
- Fordelene med å bruke CI i et utviklingsprosjekt - hvordan CI kan forbedre kodekvaliteten og effektivisere utviklingsprosessen.
- Hvordan jobber vi med CI i GitHub rent praktisk? For eskempel i et utviklingsteam på fire/fem utivklere?

### B. Sammenligning av Scrum/Smidig og DevOps fra et Utviklers Perspektiv

I denne oppgaven skal du som utvikler reflektere over og sammenligne to sentrale metodikker i moderne
programvareutvikling: Scrum/Smidig og DevOps. Målet er å forstå hvordan valg av metodikk kan påvirke kvaliteten og
leveransetempoet i utvikling av programvare.

### Oppgave

1. **Scrum/Smidig Metodikk:**

- Beskriv kort, hovedtrekkene i Scrum metodikk og dens tilnærming til programvareutvikling.
- Diskuter eventuelle utfordringer og styrker ved å bruke Scrum/Smidig i programvareutviklingsprosjekter.

2. **DevOps Metodikk:**

- Forklar grunnleggende prinsipper og praksiser i DevOps, spesielt med tanke på integrasjonen av utvikling og drift.
- Analyser hvordan DevOps kan påvirke kvaliteten og leveransetempoet i programvareutvikling.
- Reflekter over styrker og utfordringer knyttet til bruk av DevOps i utviklingsprosjekter.

3. **Sammenligning og Kontrast:**

- Sammenlign Scrum/Smidig og DevOps i forhold til deres påvirkning på programvarekvalitet og leveransetempo.
- Diskuter hvilke aspekter ved hver metodikk som kan være mer fordelaktige i bestemte utviklingssituasjoner.

#### Forventninger til Besvarelsen

- Din analyse bør være balansert, kritisk og godt underbygget med eksempler eller teoretiske argumenter.
- Reflekter over egne erfaringer eller hypotetiske scenarier for å støtte dine argumenter og konklusjoner.

### C. Det Andre Prinsippet - Feedback

Tenk deg at du har implementert en ny funksjonalitet i en applikasjon du jobber med. Beskriv hvordan du vil
etablere og bruke teknikker vi har lært fra "feedback" for å sikre at den nye funksjonaliteten møter brukernes behov.
Behovene Drøft hvordan feedback bidrar til kontinuerlig forbedring og hvordan de kan integreres i ulike stadier av
utviklingslivssyklusen.

## LYKKE TIL OG HA DET GØY MED OPPGAVEN!
