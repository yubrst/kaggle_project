# kaggle_project
# Анализ оттока клиентов телеком-компании (Telco Customer Churn)

## О проекте

Аналитический проект по исследованию причин оттока клиентов телекоммуникационной компании. Цель — выявить ключевые факторы, влияющие на уход клиентов, оценить финансовые потери и предложить рекомендации по удержанию.

**Датасет:** [Telco Customer Churn от IBM](https://www.kaggle.com/blastchar/telco-customer-churn) (Kaggle)

---

## Бизнес-задача

Телеком-компания сталкивается с высоким уровнем оттока клиентов, что приводит к значительным финансовым потерям. Необходимо:
- Оценить масштаб проблемы в количественных показателях
- Выявить сегменты клиентов с наибольшим риском ухода
- Сформулировать рекомендации по снижению оттока

---

## Описание данных

| Параметр | Значение |
|----------|----------|
| Количество записей | 7,043 клиента |
| Количество признаков | 21 |
| Целевая переменная | `Churn` (Yes/No) |

### Основные группы признаков:
- **Демография:** `gender`, `SeniorCitizen`, `Partner`, `Dependents`
- **Услуги:** `PhoneService`, `InternetService`, `OnlineSecurity`, `TechSupport`, `StreamingTV` и др.
- **Контракт:** `Contract`, `PaperlessBilling`, `PaymentMethod`
- **Финансы:** `MonthlyCharges`, `TotalCharges`, `tenure`

---

##  Инструменты

- **DBeaver** — работа с базой данных (SQLite)
- **SQL** — извлечение и анализ данных
- **Power BI** — визуализация результатов
- **GitHub** — хранение и документирование проекта

---

## Этапы анализа

1. **Загрузка и изучение данных** — знакомство со структурой датасета
2. **Общая оценка оттока** — расчет базовых метрик
3. **Сегментный анализ** — изучение оттока по ключевым признакам
4. **Визуализация** — создание дашборда в Power BI
5. **Формулировка выводов и рекомендаций**

---

##  SQL-запросы

Запрос 1: Общий уровень оттока

```sql
SELECT 
    COUNT(*) AS count_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS nochurn_customers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS churn_rate,
    ROUND(SUM(TotalCharges)/COUNT(*), 2) AS total_revenue,
    SUM(CASE WHEN Churn = 'Yes' THEN TotalCharges ELSE 0 END) AS churn_revenue
FROM WA_Fn_UseC;

Запрос 2: Общий уровень оттока
SELECT 
    Contract,
    COUNT(customerID) AS total_clients,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_clients,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS churn_rate
FROM WA_Fn_UseC
GROUP BY Contract
ORDER BY churn_rate DESC;

Запрос 3: Отток по стажу клиента

SELECT 
    CASE 
        WHEN tenure <= 6 THEN '0-6 месяцев'
        WHEN tenure > 6 AND tenure <= 12 THEN '7-12 месяцев'
        WHEN tenure > 12 AND tenure < 24 THEN '13-24 месяцев'
        ELSE 'Более 24 месяцев'
    END AS tenure_group,
    COUNT(*) AS total_clients,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_clients,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS churn_rate
FROM WA_Fn_UseC
GROUP BY CASE 
        WHEN tenure <= 6 THEN '0-6 месяцев'
        WHEN tenure > 6 AND tenure <= 12 THEN '7-12 месяцев'
        WHEN tenure > 12 AND tenure < 24 THEN '13-24 месяцев'
        ELSE 'Более 24 месяцев'
    END
ORDER BY MIN(tenure);

Ключевые выводы
1. Критический уровень оттока клиентов
26.54% клиентов покинули компанию (1,869 из 7,043)
Потерянная выручка составила $2.86 млн из общей выручки ~$20.6 млн
Уровень оттока превышает отраслевую норму для телекома (15-20%) на 6-11 процентных пунктов
2. Клиенты с помесячным контрактом уходят в 15 раз чаще, чем с двухлетним. Отсутствие долгосрочных обязательств — основной драйвер оттока.
3. Более половины клиентов уходят в первые полгода. После 2 лет обслуживания клиенты становятся лояльными. 
