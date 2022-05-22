object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 187
  Width = 271
  object fdConn: TFDConnection
    Params.Strings = (
      'Server=localhost'
      'Port=3390'
      'DriverID=MySQL')
    Left = 56
    Top = 88
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 144
    Top = 24
  end
  object ImageList: TImageList
    Left = 168
    Top = 112
  end
end
