USE [Sysfore_DB]
GO

/****** Object:  Table [dbo].[Applications]    Script Date: 26-05-2026 13:04:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Applications](
	[application_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[drive_id] [int] NOT NULL,
	[application_date] [date] NULL,
	[created_on] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[application_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Student_Drive] UNIQUE NONCLUSTERED 
(
	[student_id] ASC,
	[drive_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Applications] ADD  DEFAULT (getdate()) FOR [application_date]
GO

ALTER TABLE [dbo].[Applications] ADD  DEFAULT (getdate()) FOR [created_on]
GO

ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Application_Drive] FOREIGN KEY([drive_id])
REFERENCES [dbo].[PlacementDrives] ([drive_id])
GO

ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Application_Drive]
GO

ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Application_Student] FOREIGN KEY([student_id])
REFERENCES [dbo].[StudentDetails] ([student_id])
GO

ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Application_Student]
GO


