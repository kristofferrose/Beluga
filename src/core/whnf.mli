(**
   @author Brigitte Pientka
   modified: Joshua Dunfield
*)

open Syntax.Int.LF
open Syntax.Int


val whnf       : nclo -> nclo
val whnfTyp    : tclo -> tclo
val norm       : nclo -> normal
val normKind   : (kind * sub) -> kind
val normTyp    : tclo -> typ
val normFt'    : front * sub -> front
val normClTyp  : cltyp * sub -> cltyp
val normTypRec : trec_clo -> typ_rec
val normSub    : sub  -> sub
val normSpine  : sclo -> spine
val normDCtx   : dctx -> dctx
val normMCtx   : mctx -> mctx
val reduce     : nclo -> spine -> normal
val whnfRedex  : nclo *  sclo  -> nclo

(* conv* : true iff arguments are alpha-convertible *)
val conv        : nclo         -> nclo         -> bool
val convHead    : (head * sub) -> (head * sub) -> bool
val convTyp     : tclo         -> tclo         -> bool
val convTypRec  : trec_clo     -> trec_clo     -> bool
val convSchElem : sch_elem     -> sch_elem     -> bool
val prefixSchElem : sch_elem     -> sch_elem     -> bool
val convSub     : sub          -> sub          -> bool
val convITerm   : iterm        -> iterm        -> bool
val convMSub    : msub         -> msub         -> bool
val convDCtx    : dctx         -> dctx         -> bool
val convCtx     : typ_decl ctx -> typ_decl ctx -> bool

(*************************************)
(* Creating new contextual variables *)
(*************************************)

val newMMVar'   : Id.name option -> mctx * ctyp -> depend ->  mm_var
val newMMVar    : Id.name option -> mctx * dctx * typ -> depend ->  mm_var
val newMPVar    : Id.name option -> mctx * dctx * typ ->  depend -> mm_var
val newMSVar    : Id.name option -> mctx (* cD *) * dctx (* cPsi *) * dctx (* cPhi *) -> depend -> mm_var 
                  (* cD ; cPsi |- msvar : cPhi *)

val newMVar     : Id.name option -> dctx * typ -> depend -> cvar
val newCVar     : Id.name option -> mctx -> Id.cid_schema option -> depend -> ctx_var

val raiseType   : dctx -> typ -> typ


(*************************************)
(* Other operations *)
(*************************************)

val etaExpandMV     : dctx -> tclo -> Id.name -> sub -> depend -> normal

val etaExpandMMV    : Syntax.Loc.t -> mctx -> dctx -> tclo -> Id.name -> sub -> depend -> normal


exception Fmvar_not_found
exception FreeMVar of head
exception NonInvertible
exception InvalidLFHole of Loc.t

val newMTypName : ctyp -> Id.name_guide

val m_id   : msub
(* val mshift: msub -> int -> msub
val mshiftTerm: normal -> int -> normal
val mshiftHead: head -> int -> head
val mshiftSpine: spine -> int -> spine
val mshiftTyp : typ  -> int -> typ
val mshiftDCtx : dctx  -> int -> dctx
*)
val mvar_dot1  : msub -> msub
val pvar_dot1  : msub -> msub
val mvar_dot   : msub -> mctx -> msub

val mcomp      : msub -> msub -> msub

val m_invert     : msub -> msub

(* val invExp     : Comp.exp_chk * msub -> int -> Comp.exp_chk
val invTerm    : normal    * msub -> int -> normal
*)
val mctxLookup : mctx -> int -> Id.name * ctyp
val mctxLookupDep : mctx -> int -> Id.name * ctyp * depend
val mctxMDec   : mctx -> int -> Id.name * typ * dctx
val mctxPDec   : mctx -> int -> Id.name * typ * dctx
val mctxSDec   : mctx -> int -> Id.name * dctx * svar_class * dctx
val mctxCDec   : mctx -> int -> Id.name * Id.cid_schema

val mctxMVarPos : mctx -> Id.name -> (Id.offset * ctyp)

val cnorm      : normal * msub -> normal
val cnormHead : head * msub -> head
val cnormHead' : head * msub -> front
val cnormSpine : spine * msub -> spine
val cnormSub   : sub * msub -> sub
val cnormTyp   : typ  * msub -> typ
val cnormTypRec: typ_rec * msub -> typ_rec
val cnormDCtx  : dctx * msub -> dctx
val cnormMTyp  : ctyp * msub -> ctyp
val cnormClTyp  : cltyp * msub -> cltyp
val cnorm_psihat: psi_hat -> msub -> psi_hat
val cnormCtx  :  Comp.gctx * msub -> Comp.gctx

val cnormPattern  : Comp.pattern * msub -> Comp.pattern

val cnormMetaObj : Comp.meta_obj * msub -> Comp.meta_obj
val cnormMetaTyp : Comp.meta_typ * msub -> Comp.meta_typ

val cnormClObj : clobj -> msub -> clobj
val cnormMFt : mfront  -> msub -> mfront
val cnormMSub  : msub -> msub

val cnormCKind : Comp.kind * msub -> Comp.kind
val cnormCTyp  : Comp.typ * msub -> Comp.typ
val cnormCDecl : LF.ctyp_decl * msub -> LF.ctyp_decl
val cwhnfCTyp  : Comp.typ * msub -> Comp.typ * msub
val cwhnfCtx   : Comp.gctx * msub -> Comp.gctx

val cnormExp   : Comp.exp_chk * msub -> Comp.exp_chk
val cnormExp'  : Comp.exp_syn * msub -> Comp.exp_syn

val normCtx    : Comp.gctx -> Comp.gctx
val normCTyp   : Comp.typ  -> Comp.typ

val convMTyp   : ctyp -> ctyp -> bool
val convCTyp   : (Comp.typ * msub) -> (Comp.typ * msub) -> bool
val convMetaObj: Comp.meta_obj -> Comp.meta_obj -> bool
val conv_hat_ctx: psi_hat -> psi_hat -> bool

val closed     : nclo -> bool
val closedTyp  : tclo -> bool
val closedDCtx : dctx -> bool
val closedGCtx : Comp.gctx -> bool
val closedMetaObj : Comp.meta_obj -> bool

val constraints_solved : cnstr list -> bool
