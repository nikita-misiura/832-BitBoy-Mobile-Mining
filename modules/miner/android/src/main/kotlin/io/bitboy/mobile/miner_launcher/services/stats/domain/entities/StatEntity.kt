package io.bitboy.mobile.miner_launcher.services.stats.domain.entities

import android.os.Parcel
import android.os.Parcelable

data class StatEntity(
    val id: Int,
    val time: String,
    val data: String,
    val app: String,
    val stat: String
) : Parcelable {
    constructor(parcel: Parcel) : this(
        parcel.readInt(),
        parcel.readString() ?: "",
        parcel.readString() ?: "",
        parcel.readString() ?: "",
        parcel.readString() ?: ""
    )

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeInt(id)
        parcel.writeString(time)
        parcel.writeString(data)
        parcel.writeString(app)
        parcel.writeString(stat)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<StatEntity> {
        override fun createFromParcel(parcel: Parcel): StatEntity {
            return StatEntity(parcel)
        }

        override fun newArray(size: Int): Array<StatEntity?> {
            return arrayOfNulls(size)
        }
    }
}