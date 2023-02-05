'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "ae63c0feeeed8c8a8ac9e1cf372f97c7",
"index.html": "86c7556a3d2e7c91ddbf53f54341e128",
"/": "86c7556a3d2e7c91ddbf53f54341e128",
"main.dart.js": "d03575db779ffa4193a88e2b516b2406",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "ad0c9c779115cca96f9ab12f25ddf48b",
"assets/AssetManifest.json": "ec9ba79fb50a50baf00c41f4a06dbcee",
"assets/NOTICES": "4438438b051306fbaa6eb43090023f1b",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/shaders/ink_sparkle.frag": "8b30cb8781eaf801ac4341bfce878a85",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/images/bullet.png": "f35b61944969e005d6077b91e2020b9e",
"assets/assets/images/smoke_explosin.png": "555a8a42b72e662af232dc2092103c2a",
"assets/assets/images/tiled/image_bg.jpeg": "baac8674ee1595c79ac2ad933bf296d5",
"assets/assets/images/tiled/mapa2.json": "f40c9313ce8bbceeee7d02769762e186",
"assets/assets/images/tiled/map_tiled1.8.tmj": "577ee2d471a74620511e4a6231c3641d",
"assets/assets/images/tiled/tileset/tileset1.8.tsj": "a2a9a6c43017c3174998d36eddf9908b",
"assets/assets/images/tiled/tileset/0x72_DungeonTilesetII_v1.json": "5037c4977d6e032fb4f9802c4f21e8ad",
"assets/assets/images/tiled/tileset/0x72_DungeonTilesetII_v1.3.png": "99ee27544da829bed54efd1f22e5a588",
"assets/assets/images/tiled/bigMap.json": "17dd8bc9210702de42f27e1b62bab5bc",
"assets/assets/images/tiled/top_down/tilesheet.json": "939d92a07290780c60731c78c263f308",
"assets/assets/images/tiled/top_down/tilesheet.png": "bbd9628ccc0e7734c82ca71591f15c7e",
"assets/assets/images/tiled/top_down/map.json": "8b3ec851385f70e557ce0c22ff01ddf6",
"assets/assets/images/tiled/mapa1.json": "d8169e2f6a83fbfc5e2fe0df9231f900",
"assets/assets/images/skeletal.png": "5c14575578500305d726b8f4228108f3",
"assets/assets/images/joystick_background.png": "8c9aa78348b48e03f06bb97f74b819c9",
"assets/assets/images/soldier.png": "ce7013efe144160b1210e355a926aaf6",
"assets/assets/images/gameover.gif": "0a428344cb0c84327900ad9c00a9eb99",
"assets/assets/images/menu_art.jpg": "29f7512140a900f5aac3293edc0c4a6c",
"assets/assets/images/iron-weapons.png": "ee5f29cd3f41626ba12f248d0980bc3a",
"assets/assets/images/health_bar.png": "d73d5314068ef1f1ee8245f7d65f3241",
"assets/assets/images/tile_random/tile_types.png": "3f54b0b25f73b3270ddcd943480fdd3a",
"assets/assets/images/tile_random/earth_to_grass.png": "7504d7c5abb15cc963686ffce67b2be1",
"assets/assets/images/tile_random/earth_to_water.png": "457993098c6762efe45dd296b3255dc6",
"assets/assets/images/tile_random/tree.png": "373b98c4cf13e3eba31aeb556e10d8d9",
"assets/assets/images/joystick_atack.png": "0f5325cb2ddcba703e4c9d7d2dd266df",
"assets/assets/images/all-assets-preview.png": "724e22cb25662bf7c94b3b1ac83d83c2",
"assets/assets/images/lpc/feet/1.png": "2ed974e03ae8ac6df7b8a90988e6c1ef",
"assets/assets/images/lpc/body/orc1.png": "c69e7396b657d44f57afd9f3f54b1151",
"assets/assets/images/lpc/body/light.png": "3d41d5018dc1a56537d3376a6451641c",
"assets/assets/images/lpc/body/brown.png": "348cde94f6fbf7cca65441ae19bccfbd",
"assets/assets/images/lpc/body/skeleton.png": "de95019a45f5939391e4a49ff88f8046",
"assets/assets/images/lpc/torco/chest.png": "31cb64fb657680a0c20226eae7fc3539",
"assets/assets/images/lpc/torco/arms.png": "7834f862fa0aae30488fb285dbccce70",
"assets/assets/images/lpc/head/1.png": "85d7057dada8a67b14e0b4ebd691d897",
"assets/assets/images/lpc/gloves/2.png": "41a8a35710ac3befbab29f5b0cb07ad5",
"assets/assets/images/lpc/leg/1.png": "50190606e97dc98ff93156dcf95c3a4c",
"assets/assets/images/lpc/hair/longknot.png": "fafd02037d781328ae6ceb81cebc4f7e",
"assets/assets/images/lpc/hair/single.png": "b9e9111f8bd9288a9b903c271a5251e9",
"assets/assets/images/lpc/hair/curly.png": "2457c495445802029febfdde40884920",
"assets/assets/images/lpc/hair/xlong.png": "8e7f9106bf942f17b215aa58e62f4198",
"assets/assets/images/gold-weapons.png": "e30fba968d9498b5161bc65aac31a04f",
"assets/assets/images/health_ui.png": "219e39516312f2f6bc264357497b99cb",
"assets/assets/images/tile/floor_2.png": "30e0cfb9b909170d562797f3c94b9e90",
"assets/assets/images/tile/floor_3.png": "ad01c09b3fdbe4e4bf6fd1b385d87130",
"assets/assets/images/tile/abyss.png": "314b92ef08fc1611a77aff16b196e6c4",
"assets/assets/images/tile/floor_1.png": "30e0cfb9b909170d562797f3c94b9e90",
"assets/assets/images/tile/wall_top.png": "737b1f84a97139f7ad9b08feffe2fed2",
"assets/assets/images/tile/wall_left_and_top.png": "3e81f9880adc60e38bcf010196b31cef",
"assets/assets/images/tile/floor_4.png": "dcd3e348cb177c82af4c4e42468c3107",
"assets/assets/images/tile/floor_5.png": "a96806246eda1988656581def703199e",
"assets/assets/images/tile/floor_7.png": "2cc4b8d92ebb4c085c47775e7dfcf389",
"assets/assets/images/tile/floor_6.png": "0be91df69b67f3285475d324e66197e2",
"assets/assets/images/tile/wall_left_and_bottom.png": "a203c655efc171a629fe342cca6b8d72",
"assets/assets/images/tile/wall_bottom.png": "8e6180f8c766d18cf9883579fe98a2b1",
"assets/assets/images/tile/floor_10.png": "a96806246eda1988656581def703199e",
"assets/assets/images/tile/wall_turn_left_top.png": "11f298f3ca06fe374bd4ab383e4987f4",
"assets/assets/images/tile/placeholder.png": "e59f9ac05d806fda866eea0dcac6a57e",
"assets/assets/images/tile/wall_right.png": "6a3c56149ead613123cf0d0229085ca2",
"assets/assets/images/tile/wall_right_and_bottom.png": "c9c4b00ee7c56fd6983c0cbd2bbdb70a",
"assets/assets/images/tile/wall.png": "33675ba65d43db02d1c02d4814113206",
"assets/assets/images/tile/wall_bottom_left.png": "77340360fc4bbd3d7ae806f7e1b9797a",
"assets/assets/images/tile/wall_top_inner_right.png": "177352bb7be88ac261f97352b04466e2",
"assets/assets/images/tile/wall_top_inner_left.png": "12da3963954c55376191a4de596554e2",
"assets/assets/images/tile/wall_left.png": "72b1f35aa78d53c45278545c19258252",
"assets/assets/images/tile/floor_8.png": "65214ed2b5bbd8b06c3d5f929fdb1af9",
"assets/assets/images/tile/floor_9.png": "2258e36aa7bd7fdd378181a108442b6f",
"assets/assets/images/tile/wall_bottom_right.png": "4c3d174e5dc87337d69b3d2204ccaa9c",
"assets/assets/images/enemy/atack_effect_top.png": "df3eeb246450bf06de6dfc325d0bdbd0",
"assets/assets/images/enemy/goblin/goblin_run_right.png": "e4b26907a8714ea1805821e2bbc196de",
"assets/assets/images/enemy/goblin/goblin_run_left.png": "05863189b562610b17a062114c7849a9",
"assets/assets/images/enemy/goblin/goblin_idle.png": "8c97e935786b994c3cff4008212381b9",
"assets/assets/images/enemy/goblin/goblin_idle_left.png": "a7563675f85ed259b2d0aae50ded196b",
"assets/assets/images/enemy/atack_effect_left.png": "9c99ad913fcc75ce253f8db53faa846f",
"assets/assets/images/enemy/atack_effect_bottom.png": "aaeb1a8e791a0f15ba911e1d2540ab32",
"assets/assets/images/enemy/centipede/centipede_idle_left.png": "6eb8fa4e2595238e929d8ea21e0d5df9",
"assets/assets/images/enemy/centipede/centipede_attack2.png": "a555f4ee31e7a2e7794239cfb5ed7af9",
"assets/assets/images/enemy/centipede/centipede_run_right.png": "5948ef0772afe8947e64b1a25bca5db2",
"assets/assets/images/enemy/centipede/centipede_run_left.png": "7f9d917b59a8a4ab915de735292811a6",
"assets/assets/images/enemy/centipede/centipede_idle_right.png": "1a658276bf4ae6f9d9a7f26a55d43eeb",
"assets/assets/images/enemy/atack_effect_right.png": "15831f9ccee22a845e854ccb3d18f6e5",
"assets/assets/images/enemy/plaguebearer/plaguebearer_attack.png": "c2c261b49b214d412f89b1e77492283c",
"assets/assets/images/enemy/plaguebearer/plaguebearer_run_right.png": "45478e20f899e335225eca5f7b4b3e98",
"assets/assets/images/enemy/plaguebearer/plaguebearer_idle_left.png": "83b5949bbb9491bc14a943b2f12ce2ec",
"assets/assets/images/enemy/plaguebearer/plaguebearer_idle_right.png": "8ce0ca53064981d6437b417962060a02",
"assets/assets/images/enemy/plaguebearer/plaguebearer_run_left.png": "facb07d17563b01f84eba9a8d813deb2",
"assets/assets/images/background.jpg": "81907fa3eef76bdd516fbefac8b2ba46",
"assets/assets/images/sword.png": "5840734a0df8150a70746991c7af8119",
"assets/assets/images/profesor.jpg": "cef04f037274954fb11d90e10c29bb94",
"assets/assets/images/button_click.png": "f4d8eb05b0e45efc19ee18a6fe7e9950",
"assets/assets/images/logo.png": "f061d8bb50829d4efb4495ef750b773f",
"assets/assets/images/robot.png": "b696d8a120962de4bde2ff8b7319786c",
"assets/assets/images/zombie.png": "41ebd5de73051a779ea2aa8be90b95af",
"assets/assets/images/axe.png": "aa09e17e13e49d58c47bde67790b3482",
"assets/assets/images/bronze-weapons.png": "b797b6ed1ed6b7f971d1ae598cad8c24",
"assets/assets/images/health_bar_knight.png": "fc70d0846ad82f83ddb7ff5a3d43f4a4",
"assets/assets/images/controls.png": "5ab50acf048b7352d76dde365cdb4a3d",
"assets/assets/images/itens/potion_life.png": "fdbcfe3d903b2600b80376f98f27e164",
"assets/assets/images/itens/flag_red.png": "829574c10659e57c4fd949caad51f45a",
"assets/assets/images/itens/torch_spritesheet.png": "858f57abd642f0303de50d719532f198",
"assets/assets/images/itens/spikes.png": "8ee92dd121da5fc50964a6a68e3e262c",
"assets/assets/images/itens/chest_spritesheet.png": "bcc8785d27d816e23eca114dd4e708ed",
"assets/assets/images/itens/prisoner.png": "9c772e1a0af6bfe7da1fc6e21cb65644",
"assets/assets/images/itens/column.png": "2ccdc666f36fef12bb99345d4c6c9d66",
"assets/assets/images/itens/table.png": "4d3d7d64a6ef7fbba24ea7a32f6163a9",
"assets/assets/images/itens/barrel.png": "973ca2c4f41dd4e362179e104b92d58f",
"assets/assets/images/itens/bookshelf.png": "afed97cd52f07a9e3e73c863467c685c",
"assets/assets/images/itens/flag_green.png": "ffe83dff33bd09defb2ca55188692b71",
"assets/assets/images/button_hover.png": "cd9f84c7a75e4e1ff95acb07b95d6d95",
"assets/assets/images/blue_button2.png": "b2ac54312d3b566d324f461aa50b8f5b",
"assets/assets/images/hammer.png": "93a2d3f70fff9db4c5a6f6e0a6f3700e",
"assets/assets/images/blue_button1.png": "c5ac9ffc08055cdbb731e6bfb0d2593a",
"assets/assets/images/steel-weapons.png": "fec1cbb85b8d7aa5c1850f43453c3f93",
"assets/assets/images/joystick_atack_range.png": "8994f23fc67442c8361432f0cc9a2fa1",
"assets/assets/images/npc/critter_run_right.png": "fe08ed1dcc559998705239d5925a6ab1",
"assets/assets/images/npc/wizard_idle.png": "b05bbd5361ae3eac51138a70c8278efc",
"assets/assets/images/npc/critter_run_left.png": "145c02015fea8ed28f964ec0ca686d84",
"assets/assets/images/npc/critter_idle.png": "609755d64e5a0dbcd7b6507ab816e55a",
"assets/assets/images/joystick_knob.png": "bb0811554c35e7d74df6d80fb5ff5cd5",
"assets/assets/images/direction_attack.png": "04fa54924d587beff5005965f2caa4b8",
"assets/assets/images/furniture.png": "63948b94a5eaca29b9e523ba1d3bbaf2",
"assets/assets/images/button.png": "fac574afa19ed11b7d9508f95c2a4138",
"assets/assets/images/player/knight_idle_left.png": "e4ddca181210b0cf9555331aaf2af512",
"assets/assets/images/player/pirate.png": "3129a70b4ba971c0b0f99c386fb4b2ab",
"assets/assets/images/player/fireball_top.png": "e9a76f3ea950d6bc22f8f4cd3a22d7e3",
"assets/assets/images/player/knight_run_left.png": "ce9f3ad71135b459f6b66c892b5b9e30",
"assets/assets/images/player/explosion_fire.png": "81a3691935a18a30572870b759ad1683",
"assets/assets/images/player/atack_effect_top.png": "7b01845d595c3803a07567ee87710658",
"assets/assets/images/player/atack_effect_left.png": "5b5475da758d76f79c34429f70f7f6af",
"assets/assets/images/player/atack_effect_bottom.png": "e2406062be291971a034123fdd1757f9",
"assets/assets/images/player/fireball_right.png": "aaa2c18fe241c16e95be131619693b80",
"assets/assets/images/player/fireball_left.png": "cb3370c9039ec112af7bee6edf3e342d",
"assets/assets/images/player/atack_effect_right.png": "39b3d8583205c90284cd60f0e018f29d",
"assets/assets/images/player/knight_run.png": "8e7a3ceaba6e3920f4b3d433f3adedc9",
"assets/assets/images/player/crypt.png": "8e55febc1e2563a9d7ba4b48625ba88d",
"assets/assets/images/player/knight_idle.png": "cba9ec4b0396f7896c0947c0a412ff35",
"assets/assets/images/player/emote_exclamacao.png": "8b1897ae92f3a077e0aadaef2626d65a",
"assets/assets/images/player/fireball_bottom.png": "05522f950d8d60e15615ee9705ff2ef0",
"assets/assets/audio/wood-small.wav": "ed040ff4becffe76fb9b80ca5681ba19",
"assets/assets/audio/pain6.wav": "162ae0c5bf8704c9ca71c8e25e6cb225",
"assets/assets/audio/pain5.wav": "02c17b47b2a8e9670ba38bfe05135ebb",
"assets/assets/audio/pain4.wav": "1c8556531a6082ef226f91d72ded7093",
"assets/assets/audio/bubble.wav": "c7463dc9ab244159eee19fefaa79f1bb",
"assets/assets/audio/cloth-heavy.wav": "cc9ef9e65b24f74ae7b655a4d85fd915",
"assets/assets/audio/bgm.ogg": "69ba96755d8d2d722489bcce0b73708b",
"assets/assets/audio/pain1.wav": "909815ac5e5108c5ecbb8982ab8f9f4e",
"assets/assets/audio/bottle.wav": "1f4131749822833394065c503a959d5e",
"assets/assets/audio/cloth.wav": "9cb10fb5eaf31d0b7a4e93ae48d0a3d3",
"assets/assets/audio/pain3.wav": "197b447e62067f571c2af62e9b931fb9",
"assets/assets/audio/pain2.wav": "1a73799d220a696cadf8067a93ca89bf",
"assets/assets/audio/swing.wav": "12dc62af3096f24cc5ae2fb14f50ae67",
"assets/assets/audio/mnstr6.wav": "f457ad7d26aab45cff2fac4df24ea319",
"assets/assets/audio/ogre1.wav": "6257bd4cdc21e7cd4f69d21f688e814a",
"assets/assets/audio/beads.wav": "20f6cd833fd9b3cd71a04c9e00e3980e",
"assets/assets/audio/mnstr7.wav": "cc1e118928c1075e5db0dcf8bb4a9d60",
"assets/assets/audio/mnstr5.wav": "d24516f8e68af9a219cd2f961b44f74d",
"assets/assets/audio/ogre3.wav": "a731e9285e208f33101e6aaf2e56477e",
"assets/assets/audio/ogre2.wav": "1d323a0aedd3fd01bae0680d9295dae6",
"assets/assets/audio/mnstr4.wav": "80ab853d111ff6a6c1ad8555f704670b",
"assets/assets/audio/mnstr1.wav": "76509ccc865041457e66d80529905382",
"assets/assets/audio/lvlup.aif": "f0afa747a3625a132c36fcf6a6630bba",
"assets/assets/audio/mnstr3.wav": "f9bc64b0c87071a4a807f0cbbe0c8b40",
"assets/assets/audio/ogre5.wav": "e8fc539d3bedcabfa8dcb17d64f82710",
"assets/assets/audio/ogre4.wav": "be625031bf550d444e3ea6ced6eb4a27",
"assets/assets/audio/mnstr2.wav": "88de31a8de9fc73db3929ae71e2728f5",
"assets/assets/audio/metal-small1.wav": "af1ee2788c9f21fdd1fce794632d11e9",
"assets/assets/audio/bubble3.wav": "8dd55079abec9d04931b0a333627a2c4",
"assets/assets/audio/mnstr12.wav": "ff3a5fcde2ed8aeb3a73c41b0bc2d656",
"assets/assets/audio/giant4.wav": "2e99d69e36d6e34058de86bd6d3681d2",
"assets/assets/audio/die1.wav": "f9bf8c58450652ac5d7f515dbe519e3a",
"assets/assets/audio/giant5.wav": "056ace2f2bedec6fd9c953ba03dc423a",
"assets/assets/audio/fireball.wav": "2c428f701d62303cda329aaeab62ed83",
"assets/assets/audio/mnstr13.wav": "dd39fa24156fa8c16769a1fe69c3e65c",
"assets/assets/audio/bubble2.wav": "51b0ec6436930aa20265e6226a2e4ed7",
"assets/assets/audio/metal-small2.wav": "e0966616c5d23e173e559db4d92b7490",
"assets/assets/audio/mnstr11.wav": "248d9fe7850a13affbbea0716604110f",
"assets/assets/audio/die2.wav": "f8ca99b090542a26f7845a0cd35bca43",
"assets/assets/audio/mnstr10.wav": "c3226e9654d820bae7634ceb366d934f",
"assets/assets/audio/metal-small3.wav": "72e286b4d1c32fee1f937899d86cc564",
"assets/assets/audio/chainmail1.wav": "3a28059f9cabf032f0e58771105821fd",
"assets/assets/audio/mnstr14.wav": "959c7458120a9b9252d8a5d232a78435",
"assets/assets/audio/coin2.wav": "71f18f4eda8fde40d2a9c4b44c8ecc96",
"assets/assets/audio/giant2.wav": "c45bbd40b8293e8d7ac4ad42855bafb2",
"assets/assets/audio/mnstr9.wav": "56f3b9c2c7f7cff81ce259a0e17b6d42",
"assets/assets/audio/interface4.wav": "d3487c8492740edc122e04d4f0326982",
"assets/assets/audio/interface5.wav": "e8352bb689d55486ba5b93c7bd016132",
"assets/assets/audio/mnstr8.wav": "da38155379462b8228743a04532faf85",
"assets/assets/audio/lego-yoda-death-sound-effect.mp3": "5254af9985bcf2f20e1cad5dbc8e62d7",
"assets/assets/audio/giant3.wav": "abf77d23c0199649b6b731bb606c77f5",
"assets/assets/audio/coin3.wav": "934b1144aa4c182f150d4aad3b1ab92f",
"assets/assets/audio/mnstr15.wav": "ac5f08d53af287a9da515b7cceb38292",
"assets/assets/audio/chainmail2.wav": "6ee81c08fe5369925f2f3633fa6b8b9f",
"assets/assets/audio/wooden_break.mp3": "c02a8d0af35e5ddcbab3c24e46d41925",
"assets/assets/audio/giant1.wav": "006148ff441f12336561088c1ace3db1",
"assets/assets/audio/coin.wav": "a36bdfa96f06a28525be48fed6d3ea4c",
"assets/assets/audio/swing3.wav": "988083af915201c7a5d9e1f2850fa5a5",
"assets/assets/audio/painh.wav": "defb4bdf1b3342b32559d59714b29ba4",
"assets/assets/audio/swing2.wav": "b7a09fd250f5449e56859cf147c2e074",
"assets/assets/audio/paino.wav": "93f17d8dd506ff3727ea0eddd7a3c5fe",
"assets/assets/audio/metal-ringing.wav": "c66898f089e522f18a4d145ed89d7f45",
"assets/assets/audio/armor-light.wav": "96bdf960c4a96e42a80888ac49e236b4",
"assets/assets/audio/door.wav": "1f54fcae089c345cbf4e14158f00872f",
"assets/assets/levels/sampleLevel.png": "3169da3a928292586c65161dd8602b50",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
