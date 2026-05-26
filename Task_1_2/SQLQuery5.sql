USE [Sysfore_DB]
GO

/****** Object:  Table [dbo].[StudentDetails]    Script Date: 26-05-2026 13:04:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StudentDetails](
	[student_id] [int] IDENTITY(1,1) NOT NULL,
	[student_name] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[branch] [varchar](50) NULL,
	[phone_number] [bigint] NULL,
	[join_year] [int] NULL,
	[current_sem] [int] NULL,
	[created_on] [datetime] NULL,
	[created_by] [varchar](50) NULL,
	[updated_on] [datetime] NULL,
	[updated_by] [varchar](50) NULL,
	[is_active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[StudentDetails] ADD  DEFAULT (getdate()) FOR [created_on]
GO

ALTER TABLE [dbo].[StudentDetails] ADD  DEFAULT ('Admin') FOR [created_by]
GO

ALTER TABLE [dbo].[StudentDetails] ADD  DEFAULT (getdate()) FOR [updated_on]
GO

ALTER TABLE [dbo].[StudentDetails] ADD  DEFAULT ('Admin') FOR [updated_by]
GO

ALTER TABLE [dbo].[StudentDetails] ADD  DEFAULT ((1)) FOR [is_active]
GO


