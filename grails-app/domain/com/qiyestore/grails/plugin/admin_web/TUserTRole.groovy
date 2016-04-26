package com.qiyestore.grails.plugin.admin_web

import org.apache.commons.lang.builder.HashCodeBuilder

class TUserTRole implements Serializable {

	TUser user
	TRole role

	boolean equals(other) {
		if (!(other instanceof TUserTRole)) {
			return false
		}

		other.user?.id == user?.id &&
			other.role?.id == role?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (TUser) builder.append(user.id)
		if (TRole) builder.append(role.id)
		builder.toHashCode()
	}

	static TUserTRole get(long TUserId, long TRoleId) {
		find 'from TUserTRole where user.id=:TUserId and role.id=:TRoleId',
				[TUserId: TUserId, TRoleId: TRoleId]
	}

	static TUserTRole create(TUser user, TRole role, boolean flush = false) {
		new TUserTRole(user: user, role: role).save(flush: flush, insert: true)
	}

	static boolean remove(TUser user, TRole role, boolean flush = false) {
		TUserTRole instance = TUserTRole.findByUserAndRole(user, role)
		if (!instance) {
			return false
		}

		instance.delete(flush: flush)
		true
	}

	static void removeAll(TUser user) {
		executeUpdate 'DELETE FROM TUserTRole WHERE user=:user', [user: user]
	}

	static void removeAll(TRole role) {
		executeUpdate 'DELETE FROM TUserTRole WHERE role=:role', [role: role]
	}

	static mapping = {
		user(unique: ['group', 'role'])
		version false
		cache true
	}
}
