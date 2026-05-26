USE [Sysfore_DB]
GO

/****** Object:  Table [dbo].[PlacementDrives]    Script Date: 26-05-2026 13:04:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PlacementDrives](
	[drive_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NULL,
	[company_name] [varchar](100) NOT NULL,
	[package_lpa] [decimal](5, 2) NULL,
	[interview_rounds] [int] NULL,
	[result_status] [varchar](30) NULL,
	[drive_date] [date] NULL,
	[created_on] [datetime] NULL,
	[created_by] [varchar](50) NULL,
	[updated_on] [datetime] NULL,
	[updated_by] [varchar](50) NULL,
	[is_active] [bit] NULL,
	[company_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[drive_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PlacementDrives] ADD  DEFAULT (getdate()) FOR [created_on]
GO

ALTER TABLE [dbo].[PlacementDrives] ADD  DEFAULT ('Admin') FOR [created_by]
GO

ALTER TABLE [dbo].[PlacementDrives] ADD  DEFAULT (getdate()) FOR [updated_on]
GO

ALTER TABLE [dbo].[PlacementDrives] ADD  DEFAULT ('Admin') FOR [updated_by]
GO

ALTER TABLE [dbo].[PlacementDrives] ADD  DEFAULT ((1)) FOR [is_active]
GO

ALTER TABLE [dbo].[PlacementDrives]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[StudentDetails] ([student_id])
GO

ALTER TABLE [dbo].[PlacementDrives]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[StudentDetails] ([student_id])
GO

ALTER TABLE [dbo].[PlacementDrives]  WITH CHECK ADD  CONSTRAINT [FK_PlacementDrive_Company] FOREIGN KEY([company_id])
REFERENCES [dbo].[Companies] ([company_id])
GO

ALTER TABLE [dbo].[PlacementDrives] CHECK CONSTRAINT [FK_PlacementDrive_Company]
GO


