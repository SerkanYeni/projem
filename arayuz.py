import streamlit as st
from dotenv import load_dotenv
from langchain_community.utilities import SQLDatabase
from langchain_community.agent_toolkits import SQLDatabaseToolkit
from langchain_openai import ChatOpenAI
from langgraph.prebuilt import create_react_agent
import os

load_dotenv()

st.set_page_config(
    page_title="TerraQuery",
    page_icon="🏺",
    layout="wide"
)

st.title("🏺 TerraQuery")
st.markdown("**Arkeoloji Veritabanı Doğal Dil Arayüzü**")
st.markdown("Türkçe veya İngilizce sorunuzu yazın, veritabanı otomatik sorgulanır.")
st.divider()

def sistemi_yukle():
    db = SQLDatabase.from_uri(
        "postgresql+psycopg2://terraquery_user:terraquery123@localhost/terraquery_db"
    )
    llm = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    toolkit = SQLDatabaseToolkit(db=db, llm=llm)
    tools = toolkit.get_tools()

    sistem_mesaji = """Sen TerraQuery adlı bir arkeoloji veritabanı asistanısın.
Kullanıcılar sana Türkçe veya İngilizce sorular sorabilir. Sonuçları Türkçe açıkla.

Tablo yapısı:
- acma(id, acma_adi, lokasyon, baslangic_tarihi, sorumlu_arkeolog)
- tabaka(id, acma_id, tabaka_no, derinlik_cm, donem, aciklama)
- eser(id, tabaka_id, eser_tipi, malzeme, durum, muhurlu, buluntu_tarihi, aciklama)

ZORUNLU SQL KURALLARI:
1. "mühürlü" = muhurlu = TRUE
2. Tabaka sırası yukarıdan aşağıya: I, II, III, IV, V (I en sığ, V en derin)
3. "N. tabakanın altında" ifadesi o tabakadan SONRA gelen tabakalar demektir:
   - "IV. tabakanın altında" = tabaka_no = 'V'
   - "III. tabakanın altında" = tabaka_no IN ('IV', 'V')
   - "II. tabakanın altında" = tabaka_no IN ('III', 'IV', 'V')
4. Dönem bilgisi SADECE tabaka.donem sütunundadır, eser tablosunda yoktur
5. Sadece SELECT sorguları kullan

ÖRNEK SORGULAR:
Soru: "Açma-3'te IV. tabakanın altındaki mühürlü keramikler"
SQL: SELECT e.id, e.eser_tipi, e.malzeme, e.durum, e.aciklama
     FROM eser e
     JOIN tabaka t ON e.tabaka_id = t.id
     JOIN acma a ON t.acma_id = a.id
     WHERE a.acma_adi = 'Açma-3'
     AND t.tabaka_no = 'V'
     AND e.muhurlu = TRUE

Soru: "Helenistik döneme ait eserler"
SQL: SELECT e.id, e.eser_tipi, e.malzeme, e.durum, e.aciklama
     FROM eser e
     JOIN tabaka t ON e.tabaka_id = t.id
     WHERE t.donem = 'Helenistik'"""

    agent = create_react_agent(
        model=llm,
        tools=tools,
        prompt=sistem_mesaji
    )
    return agent

if "agent" not in st.session_state:
    with st.spinner("Sistem yükleniyor..."):
        st.session_state.agent = sistemi_yukle()

st.success("✓ Sistem hazır!")

st.markdown("**💡 Örnek Sorular:**")
col1, col2, col3 = st.columns(3)
with col1:
    if st.button("Açma-3'teki mühürlü keramikler"):
        st.session_state.soru = "Açma-3'te IV. tabakanın altında bulunan tüm mühürlü keramikleri listele"
with col2:
    if st.button("Tüm açmaları listele"):
        st.session_state.soru = "Tüm açmaları ve sorumlu arkeologları listele"
with col3:
    if st.button("En derin tabakalar"):
        st.session_state.soru = "En derin tabakaları derinliklerine göre sırala"

st.divider()

soru = st.text_input(
    "Sorunuzu yazın:",
    value=st.session_state.get("soru", ""),
    placeholder="Örn: Açma-3'te kaç eser bulunmuştur?"
)

if st.button("🔍 Sorgula", type="primary"):
    if soru:
        with st.spinner("Sorgu işleniyor..."):
            try:
                mesajlar = st.session_state.agent.invoke(
                    {"messages": [{"role": "user", "content": soru}]}
                )
                son_mesaj = mesajlar["messages"][-1].content
                st.markdown("### 📋 Sonuç")
                st.write(son_mesaj)
            except Exception as e:
                st.error(f"Hata: {e}")
    else:
        st.warning("Lütfen bir soru yazın.")

st.divider()
st.caption("TerraQuery v0.1 — Powered by LangChain & OpenAI")
