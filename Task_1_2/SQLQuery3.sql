USE [Sysfore_DB]
GO

/****** Object:  Table [dbo].[Companies]    Script Date: 26-05-2026 13:04:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Companies](
	[company_id] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [varchar](100) NOT NULL,
	[company_email] [varchar](100) NULL,
	[location] [varchar](50) NULL,
	[created_on] [datetime] NULL,
	[created_by] [varchar](50) NULL,
	[is_active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[company_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[company_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Companies] ADD  DEFAULT (getdate()) FOR [created_on]
GO

ALTER TABLE [dbo].[Companies] ADD  DEFAULT ('Admin') FOR [created_by]
GO

ALTER TABLE [dbo].[Companies] ADD  DEFAULT ((1)) FOR [is_active]
GO


