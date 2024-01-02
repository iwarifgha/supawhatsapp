const databaseName = 'local.db';
const databaseVersion = 1;
const contactsTable = "my_contacts";
const idField = 'id';
const nameField = 'name';
const createdAtField = 'created_at';
const phoneField = 'phone';
const usersTableSupabase = 'users';
const localUserTable = "user";
const aboutField = 'about';
const localIdField = 'local_id';
const imageUrlField = 'image_Url';
const isWhatsappUser = 'is_whatsapp_user';


const createContactTable = '''CREATE TABLE $contactsTable (
	"id"	TEXT NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"phone"	TEXT NOT NULL UNIQUE,
	"about"	TEXT NOT NULL DEFAULT   ' ',
	"is_whatsapp_user"	BOOLEAN NOT NULL DEFAULT 0 CHECK( is_whatsapp_user IN (0, 1)),
 	"local_id"	INTEGER NOT NULL,
	PRIMARY KEY("local_id" AUTOINCREMENT)
);''';

const createUserTable = '''CREATE TABLE $localUserTable (
	"id"	TEXT NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"phone"	TEXT NOT NULL UNIQUE,
	"image_Url"	TEXT NOT NULL DEFAULT   ' ',
	"local_id"	INTEGER NOT NULL,
	PRIMARY KEY("local_id" AUTOINCREMENT)
);''';

// 	"is_synced"	BOOLEAN NOT NULL DEFAULT 0 CHECK( is_synced IN (0, 1)),
//DATETIME DEFAULT (STRFTIME('%d-%m-%Y   %H:%M', 'NOW','localtime'))
//  "sql_id"	INTEGER NOT NULL UNIQUE,,