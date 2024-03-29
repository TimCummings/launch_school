
[comment]: # (day_06.md)

# Advent of Code 2020

## Day 6 - Custom Customs - 12/6/2020

### Part 1

As your flight approaches the regional airport where you'll switch to a much larger plane, [customs declaration forms](https://en.wikipedia.org/wiki/Customs_declaration) are distributed to the passengers.

The form asks a series of 26 yes-or-no questions marked `a` through `z`. All you need to do is identify the questions for which **anyone in your group** answers "yes". Since your group is just you, this doesn't take very long.

However, the person sitting next to you seems to be experiencing a language barrier and asks if you can help. For each of the people in their group, you write down the questions for which they answer "yes", one per line. For example:

```
abcx
abcy
abcz
```

In this group, there are `6` questions to which anyone answered "yes": `a`, `b`, `c`, `x`, `y`, and `z`. (Duplicate answers to the same question don't count extra; each question counts at most once.)

Another group asks for your help, then another, and eventually you've collected answers from every group on the plane (your puzzle input). Each group's answers are separated by a blank line, and within each group, each person's answers are on a single line. For example:

```
abc

a
b
c

ab
ac

a
a
a
a

b
```

This list represents answers from five groups:

* The first group contains one person who answered "yes" to `3` questions: `a`, `b`, and `c`.
* The second group contains three people; combined, they answered "yes" to `3` questions: `a`, `b`, and `c`.
* The third group contains two people; combined, they answered "yes" to `3` questions: `a`, `b`, and `c`.
* The fourth group contains four people; combined, they answered "yes" to only `1` question, `a`.
* The last group contains one person who answered "yes" to only `1` question, `b`.

In this example, the sum of these counts is `3 + 3 + 3 + 1 + 1` = `11`.

For each group, count the number of questions to which anyone answered "yes". **What is the sum of those counts?**

To begin, [get your puzzle input](https://adventofcode.com/2020/day/6/input):

```
cady
ipldcyf
xybgcd
gcdy
dygbc

rwhvugmspoyzfbnlcxqtdj
avqdpntxrclufbjswgzh
qbvwgzpfsrjtdxnculh
jhrpclwdxgqibfsntzuv

gxqezucvaowipbsdr
zvoqciegxabwudrps
gecawpxvdrqzioubs

vlta
tavl
latv

znjwr
grzynwjdpe
jnrwz

mldxjabiuckefzrhywogtq
hgflyratmezidxowc
gwiavxlrstzfchymoed
oyedcrlfmawhxvzgit

kl
kql
kl
lk
lk

anf
fan
zanf
fnae
zafn

bwfxjsmovghz
ojibsmhxg
mxhgjobs
bjgxhosm
xbmsjpoheg

tvujfaqxkpirgbnyde
xbmtadenhqwpcjl
dcxezoptnlajwqb

sxcvq
rxqckvas
idsvlyczqtxo
cqeujvxs
vacqfpxksg

ujek
eukj
kzxejdg
ekrjfyw

rhosjkf
ajfhekrs
yrdkjshvcfo
sryvfjkph

l
p
l

nbrmvjxdy
trhcxfjdegby
xrbdjoqy
ubjydrxmpk
rbwjxsdyv

xygocl
lygoxc
ygxocl
olcgxy

pai
ipyw
biuvxdlsrz

h
g
yh

rgib
zathbrm
rthkbx
frbsnpeqyov

encvxrbdfawzqs
sdknfaquybvw

dtckazwsxrlhjeyi
exoahjrikulpztwfc
joilqaxewktrchz

keyspo
skyeop
okeyps
pekaoygs

lgxwytzvbhauemdir
yevalwdbpgzutimrxhq
maileyhvrubwxtdzgq
tmbjeghxlywzsudvira
dievrwylagbtmhuxz

xnlfbjqdoyp
olbrjxypfq
jsxylqfpbo

exwdrgyn
rtwldyng
mcbkdpqsyaionghfwr
nygrdw
ndrwvygzj

rywk
lhkewboru
pkirwn
sgcrwipk

bkdinatzpvwr
vephqsjxrktznbaw
wznkprbtvia
nligrkupyzwtdavb
btziarpkngvw

us
nsue
cuso

xkjgnv
ckgvqjnxs

bagwlk
lfvkwg

vgheapjblkfmztyxd
fhtqpdulcabjgemynkz
jbohsempzdfiakgylt

k
v
kd
d

xdfinmksvbzyagj
dsyokf
dyshufk
pstdwqyfkh
odcksrfy

ktjrhcmxegi
hcgiexktrjm
jthcegmrxik

gmk
kgm
gkm

sfetmaqgdlzbwxpcvyhoij
tynliwkhdjqexpafm
maqyjwixfphlentd
hmifurwajteyxdlqp

hkl
hlk

qjkgenvtlrduy
mxwcbhvsifpzoa

lmqnek
ikle
olek

btcnlxuh
uchlntbx
cnbtluxh

kuwciyjznd
dwjyunzkci
iuzykjnwdc
zdcwjuyikn
wujzdcknyi

kmygjferih
gewjmsykcqfrhxiv
fjrmkydghei
hjykfemgri

ktldfrcqpvgzisbjnoe
ladoibuscgntqekzpfvj
vejibocqgztnkpldsf

fahlzrqjxv
rlhjvqx
rioltxqjhs

tzdewcosbi
mwtsbezdick
iswotzevdcb
ecvdszbtiw

qyuowsetikpar
ytwgp
ptdxywv
wytp
txlgypw

irjbhysqofx
ckdvuonfxgtl
yfewoarzhjmxs

widzueoshfvxpy
vzuyihefspdxw
ayvpfqizxshwude

dfgztxy
uztxf
nofctkqv

ao
naolp
oa
oa
oa

dpwfujoxvnktl
vekbhcyjdu

en
n
n
n

jquynzapovkgdhc
gopazyucqhkdnjv
cpohvgkjuanqydz
kycduqpghsnozajv

itawoxecv
avxtcwenio
xebicyvtuhwog

iqovjtwyhanelbg
lwvjtionhgyqbae
evjoquglnwhyaitb
ntjilwyoaqvehgb

sqivjzpmkorlbwh
pmjvhkqbrzwosil
vkoiqmdbrlhpzwsj
mucljwzsvrkhpqiboe
vwjmqhobzskpilr

tprevw
prte
rhwkpt
fmroidptaj

wablxvpqz
byexlwv

tcqsyohw
ohqwcsyt
ctyehowsq
whcqstoy
qtohswcy

pz
pixaz
pzd
pz

nwuikyve
nyvewkiu
iyvkwunez
vkniyewu
wuivnkye

eytdnkbazpmwg
mgbtacdwkyenp
geyptwduabnzmkh
teswyamrxbknpjg
tkbcywpengma

mjxavd
gyutzrfal

fvcizraqbesujko
uienrftwaylzdc

uincmblfertod
qdoktbjlnvzehrxgspy

jvcqkryilgpwfntxums
xirbvakwlsfjycqn
rysiawecnlxkvqfjzhd
rvxycqlinhjswkfo

mdvnkegyacoru
wicopyauvghfnredstmk
cenomkayrudvgz
vnagokzyrdemcu
uqynearvkcdomjg

ly
ysl

vpictsgwzxm
trgwsxvzci

qdkcbwhn
ncbrkhdqw

sixgyadetw
vmdiwknxfh
dgwxiyura
qeuwgizxdp
lrpwocdbiajx

vnwysrfutb
fbnrytuvs
orbivfdypstlun
bvnurtfys

sgkoh
hokgs

mqouzflbs
lmzsyo
lmszixyo

mkzp
mzkp
umzpk
pkzm

ulpj
jpul

gelws
sple
tsqekvolbczxan

grhebl
gblreh
bgherl
behglr

fevslgjktqazhorycpxw
lcmukypbsoxedvf
xosyfvpckenli

jxyiconfuzmbsaevtwhldrp
xmefakdwocsrzbnivhtl
wgznhsqfvtbcxamleiord

hdtjrpawu
sjraptcdhwu
ptrwajdhu
twadpjrhu
rpaudwthj

motjpfylnx
fnoyjpmlx
ofplnxjmqy

anhjilfkyrmxzvceub
eadlxybhfvcjinwzmrkou
pxksjvnmylraicghzftbe
dkyzimvbcjxraelhnf
yivnzebljhxfkrcma

gut
tgu
utg

nzrbtjvdm
jdtvbmznr
znjrmtvdb
dmvnrbztj
bdjzntmvyr

jwszypbxieafrdnch
aschejbznfx

xochndwqpvzmyguflkbtrsaeij
xfhqyitrlcnewsjzvdpakgombu

eks
kep
ek
ek
ke

xulgsdaeicz
pntklwzvb

zqrma
cxzaikm
atywgdmuvsnl

lwzxqithm
ovgsp

arozwi
aiwqz
iwgkbz
iucwzdxps

frbyoen
ovyfenc
seyhioxwztk
enuogly
qomye

rvxnqd
vdqrny
mrnlqvd
szvqrnbdx
vdrqoguhain

xowaq
wqovn
bmghtco
okar

nflvbdqgrjsko
rgbjndlosfvkq
ndklgqovrbfxjs
svkeqbjflordgn

m
ao
wu
s
a

wkrfzvohsylcdegiq
fhwxcqlsoizk
qflzcwjhsoik
wiqlhoxcfskz
wclhtnspioamzfqk

ldtackmr
pxestymrz
yrwtmup
gmqvnrjfit

t
t
bph

nywitsj
tqvrlnwhgs
mtaidusnywxk

gxcyd
cdxgyf
kxycg

il
l
lb

guna
nufa
anuqvrj

eoulsfcqmnrvjgxiat
tlargoxfvisumecjkqn
rjgnseatxoivqlcfum
suvlciaxrtngqmehofj

glkcfvztmsqdb
sjdowcmxtvlzqbg
tpryhgedzcumbasl

taumpvcels
tvsuepcalm
pveumsatlc
masvuletcp

z
z
yz
z
z

mp
pm
mp
mp
pm

xwckdmsnh
kwsxviun

iuzmajtxolf
awfmvjuoilxzte
ztfmixyoqrljua

sjgeqy
yzxnmri
ykdmixrv

cm
m

awnvypxbcdl
cnpydlxawb
dcpxylbanw
xnydlbcwap
bdxpncwlay

uj
xhfu

zrsiauqehwb
ceqwsbai

l
l
lp
l
lv

azuxqnhyecdslbojwf
nyxzefuasjbolwqc
wlgzqjxvtfpuoebycmnkasi

ckuziyfdetswr
yezwutficsdk
sykftuwcezid

spdvxqwk
pdvksx
sdpkvx

v
azp
c
ci
c

gf
lv
k
k
lv

dvnxstyjharkqgfcpzoebml
brhaizuseyjpmgotdvkxcfq
xomkprgcdfbwjystazeqvh

rehopfalvz
imhjprwqyzeo
zstpundkbcgx

ewilz
lziew
welzi
lzeiw

qxthsijdgcywpnk
dsnptchxqjwy

ukbjit
bjuit
uibzjtnxm
ibjtu
ibpujt

chokmipvwlfryztenqxu
iuxefydlatrphvznokq
tdxkivblonrezsqyuhfp
qnultkpixrvzfeoyh
kutqzydxnvjohriplfe

ksilczxfgabryuj
nqyfczjhdoxsleuagbki
bpfcseykgjzaxluih
kcsfiubjvtxazgmwyl

ircxknguzj
icznmrugxjk
jknciurgzx
zckrijnxgu
jxgrczknui

fhslg
rleopshnu
hsflg

etsigcxpofakmq
aqskpecgitfyxhomn
kfxpqgaoceismt
qxpmikgaseftco

wb
wb
ab

i
szivqg
im
i
i

jnq
j

sy
ys
asuy
ys
vyis

upvcjtqwergyib
bjhn
bfdj
jb
bahj

yiclqgj
qlcjxgiy
qgyljic
qiyjglc
ycqjilg

uitoacvrg
bithcfgyosevr
rvocgmitn
itcjngovr

epbwxvdz
ldvx
dxvn
vdx
vdx

jatsqkxuhdrpbecnylvmfzigw
lxemqiyfwbskonhptjdzurcagv
ifwpcvjzkmhuqbsnyatdrxgel

w
w
w
w
w

z
e

pmr
b
ju
be
eb

gw
gw
gw

dbizovcyxmusfwae
gjrhpklqt

msi
s
s
s

meykd
wyhmb
yxm
dyxomt

dxjyuwfelbnsqzc
otiaxcwfeqdgnjuz
jzxnrcdquvefw
czfwmjuqkxden

svour
rvuwso
ourbsvj

ubil
u
u
du

uqtadhzrnxcvspl
mkefnjsoxy
msnigx

tb
pbt
rbt

lpdrxvuaqgjzmshwkntoibfy
whmlbyrukqjzpagvofcdenxst

muviezfdk
qukvfyeisr
ikuyfs
tgljkihfwauc

airkzuthfwsgepj
jqcsowhuxratfgkp

kwqiftygb
bqcgk
bgcklaq
kvaqbg
sqbkgl

aoqnmrfg
daqmgnf
mfgaqnu
wmpahinkgjqbe

mwreujqsnibvzg
mweizqrujbnvsg
jnzrbgsvmiqewu

vztidxa
azdtxiv

hrxmwsuig
mhigxsurw
usrhxigmw

cfebnouykgx
koxsucqgyraf
juktchzofvyipxwgdlm

hx
xh
hx
hx
hx

mduw
wmdnpu
mduw
dwum

wutmabgchq
uazbkx

pjbyczfgslqen
znekrqpjwsclyigfb
jypsgxaqfznlebc
bpcfqeltsynzjg

tsxublnfe
lrtfspbn

izolf
iofz
xuqfiny

o
lom

ojzmfxhikdcypueg
pvxcfmoyguejkqr
spweltkufjvgoymcx
mkucjyesbogxp
ecmpynakxjguo

zdouqevfi
rnqzpoufv
hvumclzqbosywafgx
fjutvokzq

pkvghyjfrdu
vfghyjdr
lvgjyhbidaftroc
hfedvjyqrg

jxiuzblvkmyegsnofq
nlbmquvyzjdpfxgseiwc
mjbgehyqkxlvzfntiusr

aczfpmyuwstqbjhednxlo
yecdxblpfmanzwsuojthq
bsjxzityancldmquefwhpo

lvnyfcu
vxcylfq
tvqkylcu
vblscjyf
dlcmyrwoapviez

wberan
ouzcxydhn

bvpzg
pvzb

lbmnpuiyctxrevsdhfkjz
enlkmziauvcbftydrpxshj
oxnlhmsdzjriuftckeybpv

t
r

bfhgolnuptvjsxym
amlwuokyvbitjfghsnrc
yvfgmlehjbxnotsu

ckqgw
qgvkwc
wmgckq
kgwcq
qwkgc

cnpedr
pevnc
nbcpt

grkun
kgpnur
nugkr
rnkgu

somqp
pouqma
compqy

ruqhzxb
qbhru
qbrhuj

mtukhzvjlcpbsao
luvynbjqerifzwoxgph

rqjikzu
pgbnltefkj

nomhpazbfcuyktxqiwgl
ezymcifpgwxabqnoth
jfitzgwocnpqyabmhx

tapvqkdegyfxhucjinmb
ujratdgqmphkfxyivbn
dtyxkgqjvbhimfnaup

notivlm
omilvnt
ioltnvm
vitomnl

bzipxlfwqocrev
ezqnpmioytdbfr
zrpfoqubesi

kmaplbsjvdchxwyn
nycxswbhajdpk
pnkjuwdyscaxhb

sabngehtj
aetjghs
aetxhsogj

xazifjcsrhqvotnwbuyke
sanqejbycdwifrxvhzp

psqc
pmq
rjqvygzka

zx
z
z
zq
z

tcfsxal
olcfxas
ctxslaf
afcxsl

yofme
omfe
yfoem
umfeozjv

s
s
bsk

ipwujhmlxfqedtgkasvbrozc
eacjpdkwqhugtvlbsifrozm
hdjqmcalsefbpizokruvtw
sqzcmptjwvkfaehnolbrdui
zubmdsipaltehvcjkfrwoq

q
w

mgtouezsxpqakjnl
avomlkdet
cmitdakloe
kyafiltewmo
dhmelcbtoawk

weqysz
wvuqybse
sqexlw

grohujnmf
jowaptgxryb

vmankdpz
ezaxt

adkxmvpjgnswzy
gxmndzkryjapsvw

lmoqnvsfaxuhd
couflmndvqhsja
nrdsoavbhfqumi

nopql
mqlopn
lqonp
plnoq
olqpn

rndkilzmstjeg
imnerzgtlkjs
ilkgrtndmzesj
jgzmtlrikens
oplrmkcgzeisntvj

wkveobq
vbmwyez
jtixfdplug

fkog
xgnvprf
gwfot
fqtg
kfgj

rmkbpqiczyatsue
arbkqwtihsnepzuyl
itsdgzekyuajopqrbvf

tsogfdjmiweuplryc
entpjmiwkbydcusgq
ytwcdugmsikejp

gtifu
fgut
maugfqt

lydezqgconibxhptr
rvhpziextcgqdn

lomz
ote
horj

xeljfmtougnbavpdrcqw
lxporgjacuebvtsfqdn
cxbzydvfqplijngrtuoahk
dcbfxjownqtpagvulr

sdgt
gtsd
tsdgr
dtgs
dgst

odwjlyk
yc
bgrhvyniq
pykje
ykflz

dgsx
xsdg
dxsg
gdsx

wtp
wpiyl
qxev

rtionqlhjx
zroknluimtqbxc
rtxqhoinl

yntd
ndt
ntd
dtn
mfdqtn

qbrakwdnmcjifxtogy
pygfcekrmxjqod
kycfolmdqrgxj
qkymfxodjrcg
xcmkofrjgdyq

pwyamsuvxo
ymxvapuows
zsxmupayowv
wsymavxupo

vwhqylbkdjcorgm
gwydlkobqcvjr
jqwpboghlvdcak
xjbnqwvedzkglo

oncquyf
qnfaowr
ncqfo

tvdqhwca
plxmrjeou
zfb
gsznyie

a
a
a
a

esoucni
uzfgwcnxaqstbmev
cheyisjun

jnaqvhfpoxcue
epncvjuxfbdha

zji
zji
ojiz
izj

pdysemnc
emsdnycp
sadecvmynp
mdnpjcsewy

coexuhlafgsqtb
geslfaxutqho

vknhzpqwifxelbaoy
ihgbkjqavroyzswme

lo
omu
roscv

bnus
bsun
subn

zolprckqstjga
qcsgkztrojw
rgkejwqcstomz
sgqjbkcroyzt
twqgksozjrc

pwfuqsjl
pqwijlzfbush
slwpjqfau

rsnhwkvleyq
ynwrvehsklq
sqlvnwkreyh
qulweyrvhksnboj
hvwnelyqcakrs

pchq
pcq
pcq

emibouksdlwzy
nzfvuaim

xmopwqrt
umxwteynq

hvl
hv

kpslmgyoxfnvwdzue
gufhxmrjkeovsydilqw

fntkuxiag
txinagfuk
kintafuxg
xufitgnka

gsenjvq
eqmgjv
qbgjuev
mjqgev
qvejgs

sdkecjiawgvmltuz
bqlmsrpfitcndyz

txbwf
zmpxlvbqoa
uhxiseydcnjkg

tflsahkdqbuz
afqhucrkzstdbnl
htlaeusgzxdfikqb

exnkiu
xeitkun
uexkni
kinxeu

fnkx
knf
fkin
cfnk

h
h
h

hplu
lgu
wmiq

aithpkcvxerjlygbos
xaisprobejchkyvqg
gxskbwcpfyraejhoiv
brapkfieyvjgocsxh

diowj
hcbql

fzgmaib
gzfrlipdh
vgzjbifcx
tjgwzfi

j
xh
g
t
yv

jokizbras
asizobkjr

zjveuyai
yajeivuz
juzyeiva

sxogndybtrkam
nyfwkdxa

ie
ei
ie
ei
ei

oztsejp
stzoepj

cvoutkrjs
rstjcakxoule
sucomjtrk

kgsquajhnwydi
myqeihnwztd
fwnxpyheridq
vywnzodihq

thrqlasxkwvgonmbid
irbvqgcmotzkhuxasdlj

abn
abn

fwuvdbejcmxp
pfejuvcmbxwd
uvpwfbjcxedm
cjvbexdmupwf
vbumdfwjpcex

khe
hd
dh

wqksen
nksqe
xqsenk
sqnkex

qlusg
sug
usdg
gus
gus

jdkbrvsagex
ekvrdbgas
kgvrbsdae
dkbrasgve

xabhuokifm
ubmkhfaxio
bmxufoakhi
afomihukxb

elpdrckvwjifyausq
skapiruqvcbyjnzoge

wdcxljfpsevakhgm
lvxpahdkwsmecgj
mswkvpljadexchg
xpgajdskvwlehmc

uvnfxd
ukypde
hudp
uwdbh

di
id
di
di
di

vegjlhn
uikdompq

diaq
iqa
qia
iqa
qavi

hjnedvzbrypcwt
byncjwzhvmrdxte
egpnzyxjdvbwctrh
atwrobznehdvcyj

uy
wdu
lipqvsu
agpjebnu
kmrxtfoczhu

rcdupkmhivbfz
dbuhrfpmkicavz
dzcigyhvpbfumqk

gvknrjuzah
darevkqfbushz
vhzwlkjpuari
hvrizalykctu

msqgzoy
qmgiz

qenaurhfb
nqruafhbe
ubhfrnqwaze
eqranfhbu

reknf
nr

m
m
m
m
m

qdezurshbioc
bdhrocqzusi
hsizcqdobru
hocsruziqdb
chrbiqusdoz

gdeikqytfabw
qrkhapcfl

zfqpubodgxvime
gjeitykxzplbvohqard

vz
q
q

gdpyqiv
xmhvtdoaywz
ufneysbjlvkc

tihbra
no
qmwo
o
m

g
om
wpbdvku
or

k
tk
uk

htf
kcluo
ohlscmjk
gyrvazeiqdw

xc
gcx
xc

kfuenwlpmqaxr
qukzifgdbnorva
qutcshwknrmaf
lprqafxkun
uanfqrkm

krwhnfvcgyt
dmjqxliv
lzvbdspxe
vlmuaz

x
x
x

xhlgfrmncpadtovuisbj
liaqdnuxmjofbs
xejflmsnkbudayoiz

njvuoamkpsirxg
gkvmxrqoiauj
vjucgoihdkmaxr
exgizudkrmjaovl

ikp
yv
ikz

bwgsoup
ugpwsbo
wsjnpuogb

lotn
ltkon
aoltwxbined
tnokycl
lnto

m
k
k

ecldgqtxpk
qcmpxlhkagetd
loxrdknsepvgt
gixpfzjlkted

hwp
wh
hw
whm

yknocjtxubvdfhwz
ursndjpxzo

scejb
jbecl
cejb
jcbe
jbxvec

ifdc
fiudsgjv
fumqth
pfi
rwkfoylzaenb

znubcxrwh
ubvcrzqnwx

uxym
mx
mxn

beumoprjvkt
uvrbfmepokj
mjkvpouebr
bmrvkjuope

utgaxysljbvfm
wpsdfavxogmyju
rgemjxycksfvi

mzeurqxtaoghdbc
xuebcdrothzqmga
adxtrmbczgqeohu

nhuwbty
tbuhniwy
yhtbwnu
tuwbyhn

psfgnrqozcty
wjvueck
ijdexbclhm

yxdwj
wxd
dxw

sexcrtpdvfquikblhjaym
chtlvbsyerxqupdfmjk
xlyedbvjpcqhrmutksf

nvuozspkxqrly
uydmx

kwyuicbzgnt
tnyugbicwkz
nubswzicgtyk
yzwknutbgci
zktngiucywb

rakgqzus
sqpg

mlzrs
hlpyi

r
r
r

uwckapi
kgaipwcu
wcuaipk
wapicuk

ybfnkgludqivhaorsz
wblqaofsxkvhr
rvlqakhosbwf
lsrhaqofkbv

ajqufyzreptihg
csdmvxuknlobr

bmn
bcm
bnm
bym
tbm

cphtjyqwxfisagmln
qhjlzycpsxigotwnfam
wiyxfsthnljqpmgac
mpfncbgshwyjlaxqidt

optxzqvgmlacwireyjhkfb
xkibgaquwejmdszhytnvrp

jufbthmwr
mrjbtuwfh
wmfjutbhr
bxrftjhwum
jbuhwtfrm

tzh
thz

f
f
f
f
f

bqkn
nqbk
qknb
bnkq
knbq

ydwexhmqru
hdgmjatxqeovuwc

abtg
oabytg
xgtbjh
gvtabn

cg
cg

yashgqblr
shqlraygb

bgqo
ihn

ukda
dak
mkdjczgta
akdl
dalk

a
a
a

e
b
e

kqbai
bapko
abkiq
kba
bak

sj
a

jh
jdh
fahj
hj

v
v
h
s
dr

xhwj
xhjm
whjx

wgh
vymgwjoehna
hwcg

ompt
luzvjx

nfkrushty
htrcskufyn
hkrunysft

eovbfkcaxdhzijwn
mxwkdjbzrvhcnoefai
xdbcofenviwzjapkh

nvyatuqdw
wdnvyauqt
dvqatunwy
twyavuqdn
nducyvwtqa

aijqfus
qasuij
uqsjia
rjuasqi
iesuajq

zjkvduxstlrwqhbn
hubvfndlowtzxk
nbtuzkdcwavlxph
hmnwuktxbdszvjl

fgezk
jndgyplmur
akxzg

xmbdlfr
rlwftemjuzxd

gpyldcbuom
giqfrhbmo
szxewnkjvat

tuqomcgajf
fqjaomgtuc
cjqafgmoutl
umatgofjqc

lsrfvjaw
wslvaj
slajvw
javlews

vuqeolsca
ihvqrul
kbodztqlvu
uvfpnwqjmy

pytwl
pwlty
leptwy
aypwlt
yowxhtpgl

bwcaoluzmh
gamhuwczsi
ulmoahzcw
mdhrcvyukewpza
wozuamqxch

f
f
f
f
z

h
dh
hj
ljh

tviblf
wrdsaqvky
umgexnohczj

zjy
j
ksjow
jhgxz
jzx

ct
c
cht
c
icov

vsd
wxvsdb
vdsz
ksvqmcd
svidb

xqzaucwk
uadzwkqhcx

ielspbgca
gtislbezcap
ebsgkaupic
ezgabscpi
pagibesc

crjaozusnw
vaxqblkz
fmepdtg

kylpaeoqgtbxvfmjzn
oeplfxmgzjqybnkavt
epgatylkvmozqnjfbx
kqybplxjazgftmeonv
jbzyvnqxkegopalmft

jxvqf
mfvo

f
f
m
f

txazokpwm
axoczpg
adoxzp

vytdpsizuq
tiquvwszdpjy
xyictdvlkqpgfsuz

fqabeoinxkv
udhkpbcmejy

fvktomgcdbpjxawl
dpsgbxmcvwkolafj
bevkwdgjacflpmx

xonyjrlzfmg
gjlyfnorxz
noxljrfygz
grnlofjzxy
zlxjoynrfg

gwkahb
qhkyw
gwbhk
hkcjpwls
azkbwqh

vpfdmnzj
ugcqlatijedmpv

mcnzq
onm

hnbjvmkgod
jdngkhomvb
dnbvogjmhk
ojkgvhdnmb

betpuzcnmrihwkdg
hwrgduqcznbmxtpoelsfa
gzdcwejumbvphnrt

vapidj
ujspa
epxlmkf
tgurp

umlvkjpwyi
dnwfipmv
rivbemxwph

lwvfbq
wlbf
alswbuf
fwblv
lwqfb

jredugbaknc
fndcxsqure
cqrudyszenv
fuylsvmneidrc

klxpvdicbe
rghplixcedkbv

o
zo
oujs
o

lezgicaxjpbfrkvwushdtnqmo
cizbdnotawjmxlvushkrgqpef

lwqsberxcmhuvtjy
wzmhxbyjoqlsvuecra
lmurdwxicpgfqyhbejvs
xhmbjvnutcsiewrqylk

zpbynqdhlcio
dbyhqcozpiln
bnipcozqdyhl
yondcqlzbhpi
cyqdhbpoilgnz

poygaer
by
xilybj

ozqnwilxmtvsghdpabkfrj
tohlwrznjimgkdqbpxfvsa
qanigmplokbrvstxzfwhdj
jxizrtakgopnqshdlmfwvb

gcq
nfrl

mrsyplb
nlb
kcloasx
leyuxp
dtzvfjgiqlh

rxlm
xirs
fxrasi
iwxr
grbqeox

pe
p
p
p
p

cjx
tplnqfx

cfe
ecf
nefc
sefc

lnt
lnzx
iltan
mljcy

rtsnluhmkbvjwqifgoceaz
kfmcbsanwhivruztqjgole
mkznvcrhsbtjaquloweifg
ncbeltkasfzjrwuhqiogmv
rgvasjifoctmnwkbeqhluz

lxtiuyhcqrm
mtlcrh
mtrxbhflic
mhtpecgvrl

srcfjawukbzinqmxdhy
fhixzjrkamwnscpuqgydo

owjnbisvyl
bpisjn
tisjnb

wnzixhqscam
naqxzmivwchs
qzxnascwmih
xqnsahwzicm
sqczmxnahiw

dwtjvfkncqxuh
dhgqtnkpuvjcwfx
dlkyqchfwexnvutj

ew
wue

pujbdat
radse
dwsea

ean
n
n
n
n

rzmwqiytucvpdnsfbgelh
ozgwnxmauybredhsjqvp
rxudgmvykhpeqbzswn

josbygp
vopsj
adeczmjw

fxodtyrkvmbg
pgwkovxhtyufbdm
fbxocpkligytdm
znxaemofjgqdksyt

ijxdhryqml
rsjkvmyflz
jlmrxyw

sawmtrejogfxdnhkzi
jodmbtzucfwyrpqivg

apjgcrlztebs
rotipxflzgcskjabe
bcltgzprjsae
vzreltacsjbpg

o
o
xo
zgoe
lo

koy
poyk

vagrbwxqfjlodi
ibdrvaxgfojq
qaxfgvodijbr

ficdmvaluyrpxnqg
ufgzriqpcwmdlya
akiqyhgorpsetfudjlbc

chsknb
hbszn
bzchnsx
nvsbh
dmysbnh

gdpuyxihomjscwrq
fnjsrcwyqmiloupdhx
hfqrjxcyisupwlodm

qiymdjhkzf
dhjkqfmziy
iqzmydkhfj
kmvizhqdyfj
bkzhfiyjmdq

t
tz
at
t

avrslnxdkitbycg
nbty
pbomtynjwu
fqybnht
othfnbey

xtrunekjicsm
bqofpzaw
vahlbywg

iwdh
hwd
gmnyjskwd

ikmlazfnbdorsjqeypuvthcwgx
hgjtxplaebnmqzyufcvokiswdr
wnckhtdbyufloiqepmjxgsvazr
epfzmkcvtbxhulgsiqyndrawjo
vyjortmhpxndlaeiqugwszfcbk

yotxgwldvajb
opbhatxwylvjg
vjlxbrtkawg
bolxvwgtja

gcwhiafqpe
heqwcapgif

v
v
v
v

quljvbrwcankdz
ulczjenwbqdva

iuxpgankys
aqnyupki
pjvikyxaun
opilkmnuzya
paukiynj

xghwsyorbezifcjdn
aiycwghplobmzd
icydztbguohqw
oiydgwhzbcvm

os
fbxuzm
dy

rjpyidwgfvqleb
eylqriwpbgf
piarwefgylbq
gfaebpyqilwr

pjvmiedqkbowl
pqimweboljvdk
kpjemqdbwiovl
lvmjeopbqwdik
kmpqvjilweobd

spzf
fsvpa
qspof
sfp
spf

gey
lhnmaeygb
gey
eyg

mlnpetjzfcwuhsg
miwfcjtlhpegnusz
hncpztmsfwgluej
mtjuspgcvfwelhzn
jphsncfwzulgmte

xo
ox

lmcrnftgyehbiauopxvq
qbglamtefucxihroynvp
taemubichnpfgovlqryx
arfgqvnetlmicbuhoxyp
ergfpvomtxnbchlaquiy

dpvjzhctgoarwxslq
thzvryowlpngksaxcqd

jgxqdkvcfb
xvtkfdcaqbg
abqfvgwdxkc
skpvqdbnfgxc

xkcogdlq
ogclkx
xlkuoagvfbe
gwxmlkod

ilkrwvsm

dlzhejcxgaounswfbrpyqm
juhszbwcqnmfareo

okjwxhu
dnt
pxzgny
cbs

widp
piwd
wpid
pdiw

pblk
awkpi
pkxr
kpfz

ap
p
pbyn

fbzsyicupka
zecusykamifqbpt
icpauyfksbz

seumyc
c
c
ulacyj
gpixcobt

xoe
r
rw
imx
vgca

uagdrmf
qdrymuaxfg
fmruazdg

adp
ap
pxa
pa
sagp

wtifbkzvuhnomscrxq
nvcqhximsubtrfokwz
bqznfxwohmkvutirsc
ntusvqiwhzcoxfrbkm

cpbly
clpbye
ycblp

wmaxezdjgrocuksbp
cuxkdjoea
efxuaockjd
kceoxldauj

yfndzthcqvgp
anphtqvcfz

byecawnxd
ecyndxawb

z
z
z
vz

meypsculfjd
cepvdinrls

hqiu
guis

rxvj
xvr
xilvr
ryjxv
yrvx

co
oc
co
co
oc

gyjtrueqosz
achxyfbvqkopetj

zkrvufeglcywqtx
hsekycwptiogul
eyhljkcgwtpuo
jgncytkblpweou

nxhayv
npqfohbrl
kegchuidstwnm
nzhlj
```

### Solution

6291

```javascript
// Input: string representing groups of customs declarations form answers
// Output: number representing the sum of counts of questions to which at least one person in a group answered yes
// Rules/Implicit Knowledge
//   26 customs declaration form questions labeled a-z
//   the list of answers is composed of groups of answers separated by blank lines ('\n\n')
//   a group of answers is composed of the answers of individuals on separate lines ('\n')
//   an individual's answers is a single line of a series of letters
//     if a letter is listed, that individual answered yes to that question
//   multiple yes answers to the same question a group don't matter
// Examples: see below
// Edge Cases
//   case sensitive?
//   invalid characters
// Data Structure
//   split batch string to array of group strings
//   split group string to array of individual strings
//   use object to track group's answers
// Algorithm
//   split batch string on '\n\n' to array of group strings
//   map array of group strings to count of distinct "yes" questions
//     initialize a yesAnswers object
//     split group string on '\n' to array of individual strings and iterate
//       iterate characters of individual string
//         if yesAnswers object does not have the current letter as a key, add it with a value of 0
//         increment the current letter's value by 1
//           (the question doesn't ask for repeat yes answers to be tracked within a group,
//           but it takes minimal extra effort and we still achieve the requested solution
//           just as easily)
//     return the length of the array of keys of the yesAnswer object
//   reduce by summing and return
// Code

let sumAffirmativeAnswers = function sumAffirmativeAnswers(answersBatch) {
  return answersBatch.split('\n\n').map(group => {
    let yesAnswers = {};

    group.split('\n').forEach(individual => {
      for (let index = 0; index < individual.length; index += 1) {
        let letter = individual[index];
        if (yesAnswers[letter] === undefined) yesAnswers[letter] = 0;
        yesAnswers[letter] += 1;
      }
    });

    return Object.keys(yesAnswers).length;
  }).reduce((sum, count) => sum + count);
};

// let answersBatch = 'abcx\n' +
//                    'abcy\n' +
//                    'abcz';

// console.log(sumAffirmativeAnswers(answersBatch) === 6);

// let answersBatch = 'abc\n' +
//                    '\n' +
//                    'a\n' +
//                    'b\n' +
//                    'c\n' +
//                    '\n' +
//                    'ab\n' +
//                    'ac\n' +
//                    '\n' +
//                    'a\n' +
//                    'a\n' +
//                    'a\n' +
//                    'a\n' +
//                    '\n' +
//                    'b';

// console.log(sumAffirmativeAnswers(answersBatch) === 11);
```

---

### Part 2

As you finish the last group's customs declaration, you notice that you misread one word in the instructions:

You don't need to identify the questions to which **anyone** answered "yes"; you need to identify the questions to which **everyone** answered "yes"!

Using the same example as above:

```
abc

a
b
c

ab
ac

a
a
a
a

b
```

This list represents answers from five groups:

* In the first group, everyone (all 1 person) answered "yes" to `3` questions: `a`, `b`, and `c`.
* In the second group, there is **no** question to which everyone answered "yes".
* In the third group, everyone answered yes to only `1` question, `a`. Since some people did not answer "yes" to `b` or `c`, they don't count.
* In the fourth group, everyone answered yes to only `1` question, `a`.
* In the fifth group, everyone (all 1 person) answered "yes" to `1` question, `b`.

In this example, the sum of these counts is `3 + 0 + 1 + 1 + 1` = `6`.

For each group, count the number of questions to which **everyone** answered "yes". **What is the sum of those counts?**

### Solution

3052

```javascript
// instead of return the length of the keys of yesAnswers...
// filter the keys of yesAnswers to keys whose values are equal to the size of the group

// to get the size of the group, refactor `group.split('\n').forEach`:
//   split group on newlines and assign to an individuals variable
//   the size of the group is the length of individuals

let sumAffirmativeAnswers = function sumAffirmativeAnswers(answersBatch) {
  return answersBatch.split('\n\n').map(group => {
    let yesAnswers = {};

    let individuals = group.split('\n');
    individuals.forEach(individual => {
      for (let index = 0; index < individual.length; index += 1) {
        let letter = individual[index];
        if (yesAnswers[letter] === undefined) yesAnswers[letter] = 0;
        yesAnswers[letter] += 1;
      }
    });

    return Object.keys(yesAnswers).filter(letter => {
      return yesAnswers[letter] === individuals.length;
    }).length;
  }).reduce((sum, count) => sum + count);
};
```
