
--first, to clean the Reactions table 

SELECT *
FROM Reactions                                                                       

-- to split datetime column into seperate columns for the date and time


SELECT Datetime
FROM Reactions

-- to create a date only column
SELECT Datetime, CONVERT(DATE, Datetime) AS Date
FROM Reactions

ALTER TABLE Reactions
ADD Date DATE

UPDATE Reactions
SET Date = CONVERT(DATE, Datetime)
FROM Reactions

-- to create a time only column
SELECT Datetime
FROM Reactions

SELECT Datetime, CONVERT(TIME, Datetime) AS Time
FROM Reactions

ALTER TABLE Reactions
ADD Time TIME
                                                        
UPDATE Reactions
SET Time = CONVERT(Time, Datetime)
FROM Reactions


-- to remove Datetime column
ALTER TABLE Reactions
DROP COLUMN Datetime

--to view the table
SELECT *
FROM Reactions


--secondly, to clean the Content table 

--to view the table
SELECT *
FROM Content


-- to clean the Category column
-- to change "culture" to culture
SELECT *
FROM Content
WHERE Category LIKE '"culture"'

UPDATE Content
SET Category = 'culture'
WHERE Category = '"culture"'

-- to change "animals" to animals
SELECT *
FROM Content
WHERE Category LIKE '"animals"'

UPDATE Content
SET Category = 'animals'
WHERE Category = '"animals"'

-- to change "studying" to studying
SELECT *
FROM Content
WHERE Category LIKE '"studying"'

UPDATE Content
SET Category = 'studying'
WHERE Category = '"studying"'

-- to change "soccer" to soccer
SELECT *
FROM Content
WHERE Category LIKE '"soccer"'

UPDATE Content
SET Category = 'soccer'
WHERE Category = '"soccer"'

-- to change "dogs" to dogs
SELECT *
FROM Content
WHERE Category LIKE '"dogs"'

UPDATE Content
SET Category = 'dogs'
WHERE Category = '"dogs"'

-- to change "tennis" to tennis
SELECT *
FROM Content
WHERE Category LIKE '"tennis"'

UPDATE Content
SET Category = 'tennis'
WHERE Category = '"tennis"'

-- to change "food" to food
SELECT *
FROM Content
WHERE Category LIKE '"food"'

UPDATE Content
SET Category = 'food'
WHERE Category = '"food"'

-- to change "technology" to technology
SELECT *
FROM Content
WHERE Category LIKE '"technology"'

UPDATE Content
SET Category = 'technology'
WHERE Category = '"technology"'

-- to change "public speaking" to public speaking
SELECT *
FROM Content
WHERE Category LIKE '"public speaking"'

UPDATE Content
SET Category = 'public speaking'
WHERE Category = '"public speaking"'

-- to change "veganism" to veganism
SELECT *
FROM Content
WHERE Category LIKE '"veganism"'

UPDATE Content
SET Category = 'veganism'
WHERE Category = '"veganism"'

-- to change "science" to science
SELECT *
FROM Content
WHERE Category LIKE '"science"'

UPDATE Content
SET Category = 'science'
WHERE Category = '"science"'

-- to change "cooking" to cooking
SELECT *
FROM Content
WHERE Category LIKE '"cooking"'

UPDATE Content
SET Category = 'cooking'
WHERE Category = '"cooking"'


-- to change the values in the Category column to lower case
SELECT Category, LOWER(Category)
FROM Content

UPDATE Content
SET Category = LOWER(Category)

--to view the table
SELECT *
FROM ReactionTypes


-- to create a VIEW Named SocialBuzz by joining the Content, Reactions, and ReactionTypes tables 

SELECT        dbo.Reactions.[Column 0], dbo.Reactions.[Content ID], 
			  dbo.Reactions.Type AS reaction_type, dbo.Reactions.Date, 
			  dbo.Reactions.Time, 
			  dbo.[Content].Type AS content_type, dbo.[Content].Category, 
			  dbo.ReactionTypes.Sentiment, 
              dbo.ReactionTypes.Score
FROM          dbo.[Content] CROSS JOIN
              dbo.Reactions CROSS JOIN
              dbo.ReactionTypes

--to view the table
SELECT *
FROM dbo.SocialBuzz

--below is an attempt to analyse the data

-- to get the distinct count of the categories
SELECT COUNT(DISTINCT Category) AS count_of_category
FROM SocialBuzz


-- to get the distinct count of the content_type
SELECT COUNT(DISTINCT content_type) AS count_of_content_type
FROM SocialBuzz


-- to get the month with the highest number of posts
SELECT TOP 1 DATENAME(month, DATEADD(month, DATEPART(Month, Date), -1)) AS Month,
			 COUNT(*) AS Posts
FROM SocialBuzz
GROUP BY DATEPART(Month, Date)
ORDER BY 2 DESC


-- to get top 5 categories by Score
SELECT TOP 5 Category, SUM(CAST(Score AS int)) AS TotalScore
FROM SocialBuzz
GROUP BY Category
ORDER BY 2 DESC


-- to get popularity % share for top 5
WITH Top5 AS (
SELECT TOP 5 Category, SUM(CAST(Score AS decimal)) AS PScore
FROM SocialBuzz
GROUP BY Category
ORDER BY 2 DESC
)
SELECT 
	Category, 
	ROUND((PScore / (SELECT SUM(PScore) FROM Top5)),4) * 100 AS PercentageShare
FROM Top5
GROUP BY Category, PScore
ORDER BY 2 DESC

--to get the number of posts per month
SELECT
	DATENAME(month, DATEADD(month, DATEPART(Month, Date), -1)) AS Month,
	COUNT(*) AS posts
FROM SocialBuzz
GROUP BY DATEPART(Month, Date)
ORDER BY DATEPART(Month, Date)

