package com.cellphone.model;

import java.util.Date;

public class ThongBao {
    private int idThongBao;
    private String tieuDe;
    private String noiDung;
    private Date ngayBatDau;
    private Date ngayKetThuc;

    public int getIdThongBao() { return idThongBao; }
    public void setIdThongBao(int idThongBao) { this.idThongBao = idThongBao; }
    public String getTieuDe() { return tieuDe; }
    public void setTieuDe(String tieuDe) { this.tieuDe = tieuDe; }
    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }
    public Date getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(Date ngayBatDau) { this.ngayBatDau = ngayBatDau; }
    public Date getNgayKetThuc() { return ngayKetThuc; }
    public void setNgayKetThuc(Date ngayKetThuc) { this.ngayKetThuc = ngayKetThuc; }
}
