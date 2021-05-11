-- Przygotuj trigger �taxRateMonitoring�, kt�ry wy�wietli komunikat o b��dzie, 
-- je�eli nast�pi zmiana warto�ci w polu �TaxRate�o wi�cej ni� 30%.

CREATE TRIGGER taxRateMonitoring
        ON Sales.SalesTaxRate
        AFTER UPDATE
AS
BEGIN
	DECLARE @taxRateBefore smallmoney;
	DECLARE @taxRateAfter smallmoney;

	SELECT @taxRateBefore = TaxRate FROM deleted
	SELECT @taxRateAfter = TaxRate FROM inserted

	DECLARE @percent float = ((@taxRateAfter * 100) / @taxRateBefore) - 100

	IF  @percent > 0
	PRINT 'The new value in comparison to the old: ' + CAST(@percent AS VARCHAR(15)) + '% greater.';

	IF  @percent > 30
			PRINT 'WARNING! The updated value is 30% greater to compare with the old value! ';
END


UPDATE Sales.SalesTaxRate
SET TaxRate = 100
WHERE SalesTaxRateID = 1;

SELECT * FROM Sales.SalesTaxRate
WHERE SalesTaxRateID = 1;