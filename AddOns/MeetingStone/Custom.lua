BuildEnv(...) local ALL_MENUTABLE = {value=0,text="全部"} ACTIVITY_CUSTOM_NAMES = {"要塞日常","要塞入侵","坐骑","埃匹希斯碎片","同职业战场","同职业副本","寻求帮助","直播","任务升级","副本升级","玩家活动",[998]="单刷（可见）",[101]="地狱火堡垒（史诗）",[999]="单刷（隐藏）"} ACTIVITY_CUSTOM_SHORT_NAMES = {[101]="史诗"} ACTIVITY_CUSTOM_IDS = {16,16,16,16,17,16,16,16,16,16,16,[998]=280,[101]=410,[999]=15} ACTIVITY_CUSTOM_INSTANCE = {[101]={instance="地狱火堡垒",difficulty="史诗"}} ACTIVITY_MODE_NAMES = {"开荒","带新","成就","幻化","冲分","混分","荣誉","练习","任务","日常","练级","娱乐","碾压",[255]="未知",[99]="其它",[0]="全部"} ACTIVITY_LOOT_NAMES = {"自由","轮流","队长","队伍","需求","个人",[255]="未知",[0]="全部"} ACTIVITY_LOOT_LONG_NAMES = {"自由拾取","轮流拾取","队长分配","队伍分配","需求优先","个人拾取",[255]="未知",[0]="全部"} ACTIVITY_CUSTOM_DATA = {A={[16]={1,2,3,4,6,7,8,9,10,11},[17]={5}},G={[110]={101}},C={}} ACTIVITY_MODE_MENUTABLES = {{{value=9,text="任务"}},{{value=1,text="开荒"},{value=13,text="碾压"},{value=3,text="成就"},{value=10,text="日常"}},{{value=1,text="开荒"},{value=13,text="碾压"},{value=2,text="带新"},{value=3,text="成就"},{value=4,text="幻化"}},{{value=5,text="冲分"},{value=6,text="混分"},{value=12,text="娱乐"}},{{value=3,text="成就"},{value=12,text="娱乐"}},{{value=9,text="任务"},{value=11,text="练级"},{value=12,text="娱乐"},{value=99,text="其它"}},{{value=7,text="荣誉"},{value=8,text="练习"},{value=12,text="娱乐"}},{{value=7,text="荣誉"},{value=12,text="娱乐"}},{{value=5,text="冲分"},{value=6,text="混分"},{value=12,text="娱乐"}},{{value=7,text="荣誉"},{value=10,text="日常"},{value=12,text="娱乐"},{value=99,text="其它"}}} ACTIVITY_MODE_MENUTABLES_WITHALL = {} do for k, v in pairs(ACTIVITY_MODE_MENUTABLES) do ACTIVITY_MODE_MENUTABLES_WITHALL[k] = { ALL_MENUTABLE, unpack(v) } end end ACTIVITY_LOOT_MENUTABLE = {{value=1,text="自由拾取"},{value=2,text="轮流拾取"},{value=3,text="队长分配"},{value=4,text="队伍分配"},{value=5,text="需求优先"},{value=6,text="个人拾取"}} ACTIVITY_LOOT_MENUTABLE_WITHALL = {ALL_MENUTABLE,unpack(ACTIVITY_LOOT_MENUTABLE)} ACTIVITY_ORDER = {A={[293]=119,[54]=38,[295]=117,[150]=83,[297]=123,[151]=84,[299]=125,[300]=126,[301]=127,[55]=39,[63]=47,[154]=87,[372]=20,[56]=40,[64]=48,[375]=17,[65]=49,[379]=15,[380]=14,[57]=41,[66]=50,[383]=13,[386]=12,[50]=36,[58]=42,[9]=121,[59]=43,[398]=144,[378]=16,[374]=18,[52]=37,[60]=44,[373]=19,[365]=21,[152]=85,[62]=46,[294]=118,[45]=120,[153]=86,[61]=45,[397]=138,[296]=122,[298]=124},G={143,31,30,nil,88,115,114,113,112,111,110,108,107,145,146,128,131,97,89,66,65,64,63,62,61,60,59,58,57,99,98,56,55,54,53,52,51,82,81,80,79,78,77,76,75,74,73,72,71,70,69,68,67,96,95,94,93,92,91,90,105,104,103,102,101,100,109,35,32,33,34,129,130,132,133,134,135,136,137,139,140,141,142,106,nil,28,[102]=27,[103]=26,[104]=25,[105]=24,[106]=23,[107]=29,[108]=22,[109]=116,[110]=148},C={11,10,9,8,7,6,5,4,3,2,1,[101]=147}} 