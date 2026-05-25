from dotenv import load_dotenv
from langchain_community.utilities import SQLDatabase
import os

# .env dosyasından API anahtarını yükle
load_dotenv()

# API anahtarının okunduğunu doğrula
api_key = os.getenv("OPENAI_API_KEY")
if api_key:
    print(f"✓ OpenAI API anahtarı okundu: {api_key[:8]}...")
else:
    print("✗ API anahtarı okunamadı!")

# PostgreSQL bağlantısını test et
try:
    db = SQLDatabase.from_uri(
        "postgresql+psycopg2://terraquery_user:terraquery123@localhost/terraquery_db"
    )
    print("✓ Veritabanı bağlantısı başarılı!")
    print(f"✓ Tablolar: {db.get_usable_table_names()}")
except Exception as e:
    print(f"✗ Bağlantı hatası: {e}")
