select
    (`bill/BillingPeriodStartDate` || "-" || `bill/BillingPeriodEndDate`)  as `period`,

    `lineItem/UsageAccountId` as `account_id`,
    `reservation/SubscriptionId` as `subscription_id`,
    `product/ProductName` as `product`,
    `lineItem/Operation` as `operation`,
    `lineItem/LineItemType` as `item_type`,
    `product/region` as `region`,

    `lineItem/UsageType` as `usage_type`,
    `pricing/unit` as `usage_unit`,
    SUM(`lineItem/UsageAmount`) as metric_amount,

    SUM(`lineItem/UnblendedCost`) as metric_cost,
    `lineItem/CurrencyCode` as `currency`
from `report-current.csv`
where `lineItem/UnblendedCost` > 0
group by
    `lineItem/UsageAccountId`,
    `reservation/SubscriptionId`,
    `bill/BillingPeriodStartDate`,
    `bill/BillingPeriodEndDate`,
    `product/ProductName`,
    `lineItem/Operation`,
    `lineItem/LineItemType`,
    `product/region`,

    `lineItem/UsageType`,
    `pricing/unit`,
    `lineItem/CurrencyCode`
order by `period`, `product`, `operation`
